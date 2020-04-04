# == Schema Information
#
# Table name: news
#
#  id         :bigint           not null, primary key
#  content    :text
#  status     :boolean          default(FALSE), not null
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe News, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
