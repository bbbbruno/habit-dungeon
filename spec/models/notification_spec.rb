# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id          :bigint           not null, primary key
#  kind        :integer          not null
#  message     :string           not null
#  path        :string           not null
#  read        :boolean          default("unread"), not null
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
require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:dungeon) { create(:dungeon) }
  let(:challenge) { create(:challenge, dungeon: dungeon) }
  let(:notifications) { recipient.notifications.where(kind: kind) }
  let(:news) { build(:news, :published) }

  before do
    create_enemies
    create(:admin_user)
  end

  describe '.notify_dungeon_challenged' do
    subject { Notification.notify_dungeon_challenged(challenge) }
    let(:recipient) { challenge.dungeon.user }
    let(:kind) { :dungeon_challenged }
    it { is_expected_block.to change { notifications.count }.by(1) }
  end

  describe '.notify_challenge_damaged' do
    subject { Notification.notify_challenge_damaged(challenge) }
    let(:recipient) { challenge.challenger }
    let(:kind) { :challenge_damaged }
    context 'ソロのとき' do
      it { is_expected_block.to change { notifications.count }.by(1) }
    end
  end

  describe '.notify_rank_downed' do
    subject { Notification.notify_rank_downed(challenge) }
    let(:recipient) { challenge.challenger }
    let(:kind) { :challenge_rank_downed }
    context 'ソロのとき' do
      it { is_expected_block.to change { notifications.count }.by(1) }
    end
  end

  describe '.notify_dungeon_edited' do
    subject { Notification.notify_dungeon_edited(dungeon) }
    let(:recipients) { create_list(:user, 3) }
    let(:kind) { :dungeon_edited }
    let(:notifications) { recipients.map { |recipient| recipient.notifications.where(kind: kind) } }
    before do
      recipients.each { |recipient| create(:challenge, :for_user, challenger: recipient, dungeon: dungeon) }
    end
    it { is_expected_block.to change { notifications.map(&:count) }.to [1, 1, 1] }
  end

  describe '.notify_news_created' do
    subject { Notification.notify_news_created(news) }
    let(:recipients) { create_list(:user, 3) }
    let(:kind) { :news_created }
    let(:notifications) { recipients.map { |recipient| recipient.notifications.where(kind: kind) } }
    it { is_expected_block.to change { notifications.map(&:count) }.to [1, 1, 1] }
  end
end
