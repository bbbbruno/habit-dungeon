# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dungeons', type: :system do
  let(:dungeon) { create(:dungeon, user: user_a) }
  let(:user_a) { create(:user) }
  let(:user_b) { create(:user) }
  let(:login_user) { nil }

  before do
    create_enemies
    login_as login_user, scope: :user
  end

  describe 'ダンジョン一覧' do
    it 'ログインしなくても一覧が見れる' do
      visit dungeons_path
      expect(page).to have_selector 'h1', text: 'ダンジョン一覧'
    end
  end

  describe 'ダンジョン作成' do
    context 'ログインしているとき', js: true do
      let(:login_user) { user_a }
      it '作成できる' do
        visit new_dungeon_path
        fill_in '最終目標', with: '本を毎日読む'
        fill_in '説明', with: '本を毎日読む習慣を身に付けるためのダンジョンです。'
        attach_file 'ヘッダー画像', Rails.root.join('app', 'frontend', 'images', 'headers', 'sky.png'), visible: false
        find('.delete').click
        find('.add').click
        find('.add').click
        6.times do |i|
          fill_in "dungeon_levels_attributes_#{i}_title", with: "本を毎日#{i}ページ読む"
          fill_in "dungeon_levels_attributes_#{i}_days", with: 11
        end
        click_on '作成する'
        expect(page).to have_content 'ダンジョンの作成に成功しました'
      end
    end

    context 'ログインしていないとき' do
      it 'ログイン画面へ飛ばされる' do
        visit new_dungeon_path
        expect(page).to have_content 'アカウント登録もしくはログインしてください。'
      end
    end
  end

  describe 'ダンジョン詳細' do
    before do
      visit dungeon_path(dungeon)
    end
    it 'ログインしてなくても詳細が見れる' do
      expect(page).to have_content 'ダンジョン詳細'
    end

    context 'ダンジョン作成者のとき' do
      let(:login_user) { user_a }
      it 'ダンジョン編集リンクが表示される' do
        expect(page).to have_link '編集'
      end
    end

    context 'ダンジョン作成者ではないとき' do
      let(:login_user) { user_b }
      it 'ダンジョン編集リンクが表示されない' do
        expect(page).not_to have_link '編集'
      end
    end
  end

  describe 'ダンジョン編集' do
    context 'ログインしているとき' do
      context 'ダンジョン作成者が自分のとき', js: true, retry: 5, retry_wait: 5 do
        let(:login_user) { user_a }
        it '編集できる' do
          visit edit_dungeon_path(dungeon)
          find('.add').click
          find('.delete').click
          find('.delete').click
          find('.delete').click
          find('.cancel', match: :first).click
          fill_in 'dungeon_levels_attributes_1_title', with: '本を毎日10ページ読む'
          fill_in 'dungeon_levels_attributes_1_days', with: 22
          page.accept_confirm do
            click_on '更新する'
          end
          expect(page).to have_content 'ダンジョンの更新に成功しました'
        end
      end

      context 'ダンジョン作成者ではないとき' do
        let(:login_user) { user_b }
        it '編集できない' do
          expect {
            visit edit_dungeon_path(dungeon)
          }.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end

    context 'ログインしていないとき' do
      it 'エラーが発生する' do
        expect {
          visit edit_dungeon_path(dungeon)
        }.to raise_error NoMethodError
      end
    end
  end

  describe 'ダンジョン削除', js: true do
    let(:login_user) { user_a }
    context 'ダンジョンに紐づいた攻略がないとき' do
      it 'ダンジョンは実際に削除される' do
        visit edit_dungeon_path(dungeon)
        page.accept_confirm do
          click_on '削除'
        end
        expect(page).to have_content 'ダンジョンの削除に成功しました'
        expect {
          Dungeon.find(dungeon.id)
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'ダンジョンに紐づいた攻略があるとき', js: true do
      before do
        create(:challenge, dungeon: dungeon, challenger: user_a)
      end
      it 'ダンジョンは論理削除され、閲覧のみできる' do
        visit edit_dungeon_path(dungeon)
        page.accept_confirm do
          click_on '削除'
        end
        visit dungeon_path(dungeon)
        expect(page).to have_content 'このダンジョンは削除済みです。閲覧のみ可能です。'
        expect(page).not_to have_link '編集'
      end
    end
  end
end
