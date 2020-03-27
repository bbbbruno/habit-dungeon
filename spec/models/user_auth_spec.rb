# == Schema Information
#
# Table name: user_auths
#
#  id          :bigint           not null, primary key
#  credentials :text
#  description :string
#  email       :string
#  image_url   :string
#  name        :string
#  nickname    :string
#  provider    :string           default(""), not null
#  raw_info    :text
#  uid         :string           default(""), not null
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_user_auths_on_uid_and_provider  (uid,provider) UNIQUE
#  index_user_auths_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe UserAuth, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
