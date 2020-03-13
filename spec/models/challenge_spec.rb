# frozen_string_literal: true

# == Schema Information
#
# Table name: challenges
#
#  id              :bigint           not null, primary key
#  attacked        :boolean          default("false"), not null
#  challenger_type :string           not null
#  clear           :boolean          default("false"), not null
#  difficulty      :string           default("easy"), not null
#  life            :integer          default("3"), not null
#  progress        :integer          default("1"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  challenger_id   :bigint           not null
#  dungeon_id      :bigint           not null
#  enemy_id        :bigint           not null
#
# Indexes
#
#  index_challenges_on_challenger_type_and_challenger_id  (challenger_type,challenger_id)
#  index_challenges_on_dungeon_id                         (dungeon_id)
#  index_challenges_on_enemy_id                           (enemy_id)
#
# Foreign Keys
#
#  fk_rails_...  (dungeon_id => dungeons.id)
#  fk_rails_...  (enemy_id => enemies.id)
#
require "rails_helper"

RSpec.describe Challenge, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
