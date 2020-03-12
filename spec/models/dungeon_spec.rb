# frozen_string_literal: true

# == Schema Information
#
# Table name: dungeons
#
#  id           :bigint           not null, primary key
#  description  :text
#  discarded_at :datetime
#  title        :string
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
require "rails_helper"

RSpec.describe Dungeon, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
