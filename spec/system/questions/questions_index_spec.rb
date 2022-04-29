require 'rails_helper'

RSpec.describe 'Question#index', type: :system do
  describe '質問新規追加' do
    let(:user) { create(:user) }
    let(:admin) { create(:user, :admin) }
    let(:question) { create(:question, category_id: user.category_id) }

    context 'ログイン前' do
      it 'ページにアクセスできないこと' do
        visit questions_path
        expect(page).to have_content 'ログインしてください'
        expect(page).to have_current_path login_path, ignore_query: true
      end
    end

    context 'ログイン後' do
      context '一般ユーザー' do
        before { login_as(user) }

        it 'ページにアクセスできないこと' do
          visit questions_path
          expect(page).to have_current_path root_path, ignore_query: true
        end
      end

      context 'アドミンユーザー' do
        before { login_as(admin) }

        it 'ページにアクセスできること' do
          visit questions_path
          expect(page).to have_content '質問一覧'
        end

        it '質問が表示されること' do
          question
          visit questions_path
          expect(page).to have_content '質問一覧'
          expect(page).to have_content question.title
        end
      end
    end
  end
end
