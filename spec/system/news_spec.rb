# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'News', type: :system do
  let!(:news_draft) { create(:news, :draft) }
  let!(:news_published) { create(:news, :published) }
  let!(:admin) { create(:admin_user) }
  let(:login_user) { nil }

  before do
    login_as login_user, scope: :admin_user
  end

  describe '一覧' do
    context '管理者のとき' do
      let(:login_user) { admin }
      it '下書きも含めた一覧が見れる' do
        visit news_index_path
        expect(page).to have_content 'ついにリリース！ v1.1'
        expect(page).to have_content 'ついにリリース！ v1.2'
      end
    end

    context '管理者ではないとき' do
      it '下書き以外の一覧が見れる' do
        visit news_index_path
        expect(page).not_to have_content 'ついにリリース！ v1.1'
        expect(page).to have_content 'ついにリリース！ v1.2'
      end
    end
  end

  describe '新規作成' do
    context '管理者のとき' do
      let(:login_user) { admin }
      it '作成できる' do
        visit new_news_path
        fill_in 'タイトル', with: 'ついにリリース！'
        fill_in '内容', with: <<~EOS
        ## リリースした
        ついにリリースできました！
        使い方について、くわしくは以下のリンクをチェック↓
        <%= link_to 'こちら', page_path('help') %>
        EOS
        check '公開'
        click_on '登録する'
        expect(page).to have_content 'お知らせの作成に成功しました'
      end
    end

    context '管理者ではないとき' do
      it '管理者ログイン画面にリダイレクトされる' do
        visit new_news_path
        expect(current_path).to eq new_admin_user_session_path
      end
    end
  end

  describe '詳細' do
    context '管理者のとき' do
      let(:login_user) { admin }
      it '下書きが見れる' do
        visit news_path(news_draft)
        expect(page).to have_selector 'h1', text: 'ついにリリース！ v1.1'
        visit news_path(news_published)
        expect(page).to have_selector 'h1', text: 'ついにリリース！ v1.2'
      end
    end

    context '管理者ではないとき' do
      it '下書きは見れない' do
        visit news_path(news_draft)
        expect(page).to have_content '不正なアクセスです'
        visit news_path(news_published)
        expect(page).to have_selector 'h1', text: 'ついにリリース！ v1.2'
      end
    end
  end

  describe '編集' do
    context '管理者のとき' do
      let(:login_user) { admin }
      it '編集できる' do
        visit edit_news_path(news_draft)
        fill_in 'タイトル', with: 'まだリリースできない・・'
        fill_in '内容', with: <<~EOS
        ## リリースできておりません
        残念
        EOS
        check '公開'
        click_on '更新する'
        expect(page).to have_content 'お知らせの更新に成功しました'
      end
    end

    context '管理者ではないとき' do
      it '管理者ログイン画面にリダイレクトされる' do
        visit edit_news_path(news_draft)
        expect(current_path).to eq new_admin_user_session_path
      end
    end
  end

  describe '削除', js: true do
    let(:login_user) { admin }
    it '管理者は削除できる' do
      visit edit_news_path(news_draft)
      page.accept_confirm do
        click_on '削除'
      end
      expect(page).to have_content 'お知らせの削除に成功しました'
    end
  end
end
