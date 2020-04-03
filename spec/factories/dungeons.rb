# frozen_string_literal: true

# == Schema Information
#
# Table name: dungeons
#
#  id           :bigint           not null, primary key
#  description  :text
#  discarded_at :datetime
#  recommended  :boolean          default(FALSE), not null
#  title        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_dungeons_on_discarded_at  (discarded_at)
#  index_dungeons_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :dungeon do
    title { '本を毎日読む' }
    description { '本を毎日読む習慣を身に付けるためのダンジョンです。' }
    user

    after(:build) do |dungeon|
      dungeon.levels = 1.upto(6).map { |i| build(:level, number: i, dungeon: dungeon) }
    end
  end
end
