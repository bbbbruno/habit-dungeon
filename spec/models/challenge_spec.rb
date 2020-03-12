# frozen_string_literal: true

# == Schema Information
#
# Table name: challenges
#
#  id              :bigint           not null, primary key
#  challenger_type :string           not null
#  clear           :boolean
#  difficulty      :integer          default("0")
#  life            :integer
#  progress        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  challenger_id   :bigint           not null
#  dungeon_id      :bigint           not null
#
# Indexes
#
#  index_challenges_on_challenger_type_and_challenger_id  (challenger_type,challenger_id)
#  index_challenges_on_dungeon_id                         (dungeon_id)
#
# Foreign Keys
#
#  fk_rails_...  (dungeon_id => dungeons.id)
#
require "rails_helper"

RSpec.describe Challenge, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
