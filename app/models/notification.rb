# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id          :bigint           not null, primary key
#  kind        :integer          not null
#  message     :string           not null
#  path        :string           not null
#  read        :boolean          default("false"), not null
#  sender_type :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  sender_id   :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_notifications_on_sender_type_and_sender_id  (sender_type,sender_id)
#  index_notifications_on_user_id                    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Notification < ApplicationRecord
  scope :recent, ->(count) { order(created_at: :desc).limit(count) }

  belongs_to :user
  belongs_to :sender, polymorphic: true

  enum kind: {
    dungeon_challenged: 0,
    challenge_damaged: 1,
    challenge_rank_downed: 2,
    dungeon_edited: 3,
  }
  enum read: { unread: false, read: true }

  class << self
    def notify_dungeon_challenged(challenge)
      message = "#{challenge.challenger_name} があなたのつくった「#{challenge.title}」ダンジョンに挑戦し始めました。"
      challenge.dungeon.user.notifications.create!(
        sender: challenge.challenger,
        message: message,
        path: Rails.application.routes.url_helpers.polymorphic_path(challenge.dungeon),
        kind: :dungeon_challenged,
      )
    end

    def notify_challenge_damaged(challenge)
      admin = User.find_by(user_id: "bbbbruno")
      message = "ダメージを受けました。残りライフは#{challenge.life}です。"
      challenge.challenger.all_challengers.each do |challenger|
        challenger.notifications.create!(
          sender: admin,
          message: message,
          path: Rails.application.routes.url_helpers.polymorphic_path(challenge),
          kind: :challenge_damaged,
        )
      end
    end

    def notify_rank_downed(challenge)
      admin = User.find_by(user_id: "bbbbruno")
      message = "ライフが0になったため、ランクダウンしました。Lv#{challenge.current_level}から再スタートしましょう！"
      challenge.challenger.all_challengers.each do |challenger|
        challenger.notifications.create!(
          sender: admin,
          message: message,
          path: Rails.application.routes.url_helpers.polymorphic_path(challenge),
          kind: :challenge_rank_downed,
        )
      end
    end

    def notify_dungeon_edited(dungeon)
      message = "あなたが挑戦している「#{dungeon.title}」ダンジョンが編集されました。"
      dungeon
        .all_uniq_challengers
        .reject { |user| user == dungeon.user }
        .each do |user|
          user.notifications.create!(
            sender: dungeon.user,
            message: message,
            path: Rails.application.routes.url_helpers.polymorphic_path(dungeon),
            kind: :dungeon_edited,
          )
        end
    end
  end
end
