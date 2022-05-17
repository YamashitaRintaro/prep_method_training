require 'rails_helper'

RSpec.describe 'UserCategories', type: :system do
  let(:user) { create(:user) }
  let(:user_category_nil) { create(:user, category_id: '') }

  describe 'カテゴリー選択' do
    context 'ログイン前' do
      it 'ページにアクセスできないこと' do
        visit edit_user_category_path
        expect(page).to have_content 'ログインしてください'
        expect(page).to have_current_path login_path, ignore_query: true
      end
    end

    context 'ログイン後' do
      it 'ページにアクセスできること' do
        login_as(user)
        visit edit_user_category_path
        expect(page).to have_content '面接シーンを選択してください'
        expect(page).to have_current_path edit_user_category_path, ignore_query: true
      end

      context 'ユーザー登録時にcategory_idが未入力' do
        before do
          visit login_path
          fill_in 'email', with: user_category_nil.email
          fill_in 'password', with: 'password'
          click_button 'ログイン'
        end

        it 'カテゴリー選択ページに遷移する' do
          expect(page).to have_content '面接シーンを選択してください'
          expect(page).to have_current_path edit_user_category_path, ignore_query: true
        end

        it 'プロフィール画面に遷移できる' do
          visit profile_path
          expect(page).to have_content 'プロフィール'
        end

        it '質問選択画面に遷移させない' do
          visit new_training_path
          expect(page).to have_content '面接シーンを選択してください'
          expect(page).to have_current_path edit_user_category_path, ignore_query: true
        end

        it '質問詳細画面に遷移させない' do
          visit new_training_path
          expect(page).to have_content '面接シーンを選択してください'
          expect(page).to have_current_path edit_user_category_path, ignore_query: true
        end
      end

      context 'category_id登録済のユーザーの場合' do
        it 'trainings_newページに遷移する' do
          visit login_path
          fill_in 'email', with: user.email
          fill_in 'password', with: 'password'
          click_button 'ログイン'
          expect(page).to have_content '質問を選択してください'
          expect(page).to have_current_path new_training_path, ignore_query: true
        end
      end
    end
  end
end
