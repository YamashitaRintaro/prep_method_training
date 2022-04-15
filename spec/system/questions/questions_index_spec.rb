require 'rails_helper'

RSpec.describe "Question#new", type: :system do
  describe '質問新規追加' do
    let(:user) { create(:user) }
    let(:admin) { create(:user, :admin) }
    let(:question) { create(:question, category_id: user.category_id) }

    context 'ログイン前' do
      it 'ページにアクセスできないこと' do
        visit questions_path
        expect(page).to have_content 'ログインしてください'
        expect(current_path).to eq login_path
      end
    end
    
    context 'ログイン後' do
      before { login_as(user) }
      context '一般ユーザー' do
        it 'ページにアクセスできないこと' do
          visit questions_path
          expect(current_path).to eq root_path
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