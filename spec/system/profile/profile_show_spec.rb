require 'rails_helper'

RSpec.describe 'Profile#show', type: :system do
  let(:user) { create(:user) }

  describe 'プロフィール確認' do
    context 'ログイン前' do
      it 'ページにアクセスできないこと' do
        visit profile_path
        expect(page).to have_content 'ログインしてください'
        expect(page).to have_current_path login_path, ignore_query: true
      end
    end

    context 'ログイン後' do
      before { login_as(user) }

      it 'ページにアクセスできること' do
        visit profile_path
        expect(page).to have_content 'プロフィール'
      end

      it 'ユーザーのメールアドレスとカテゴリーが表示されていること' do
        visit profile_path
        expect(page).to have_content user.email
        expect(page).to have_content user.category.name
      end

      it '編集をクリックすると、プロフィール編集ページに遷移すること' do
        visit profile_path
        click_link('編集')
        expect(page).to have_content 'プロフィール編集'
        expect(page).to have_current_path(edit_profile_path, ignore_query: true)
      end
    end
  end
end
