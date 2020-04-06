# frozen_string_literal: true

# == Schema Information
#
# Table name: news
#
#  id         :bigint           not null, primary key
#  content    :text
#  status     :boolean          default("draft"), not null
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe News, type: :model do
  describe '通知' do
    let(:user) { create(:user) }
    before do
      create(:admin_user)
    end

    context 'newsをすぐに公開するとき' do
      it { expect { create(:news, :published) }.to change { user.notifications.count }.by(1) }
    end

    context 'newsを下書きで公開するとき' do
      it { expect { create(:news, :draft) }.not_to change { user.notifications.count } }
    end

    context 'newsを下書き状態から公開するとき' do
      let(:news) { create(:news) }
      it { expect { news.update(status: 'published') }.to change { user.notifications.count }.by(1) }
    end
  end
end
