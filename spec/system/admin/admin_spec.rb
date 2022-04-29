require 'rails_helper'

RSpec.describe 'Admin', type: :system do
  describe '管理画面' do
    let(:user) { create(:user) }
    let(:admin) { create(:user, :admin) }

    context 'ログイン前' do
      it 'ページにアクセスできないこと' do
        visit admin_root_path
        expect(page).to have_current_path root_path, ignore_query: true
      end
    end

    context 'ログイン後' do
      context '一般ユーザー' do
        before { login_as(user) }

        it 'ページにアクセスできないこと' do
          visit admin_root_path
          expect(page).to have_current_path root_path, ignore_query: true
        end
      end

      context 'アドミンユーザー' do
        before { login_as(admin) }

        it 'ページにアクセスできること' do
          visit admin_root_path
          expect(page).to have_current_path admin_root_path, ignore_query: true
          expect(page).to have_content 'アプリに戻る'
        end
      end
    end
  end
end
