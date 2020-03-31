# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notifications', type: :system do
  let(:user) { create(:user) }

  before do
    login_as user, scope: :user
  end

  describe '通知一覧' do
    it '一覧が見れる' do
      visit root_path
      find('.toggle-menu._notifications').click
      click_on '全ての通知'
      expect(page).to have_selector 'h1', text: 'あなたへの通知一覧'
    end
  end

  it '全て既読にできる' do
    visit root_path
    find('.toggle-menu._notifications').click
    click_on '全て既読にする'
    expect(page).to have_content '全て既読にしました'
  end
end
