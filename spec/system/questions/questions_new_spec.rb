require 'rails_helper'

RSpec.describe "Question#new", type: :system do
  describe '質問新規追加' do
    let(:user) { create(:user) }
    let(:admin) { create(:user, :admin) }

    context 'ログイン前' do
      it 'ページにアクセスできないこと' do
        visit new_question_path
        expect(page).to have_content 'please login first'
        expect(current_path).to eq login_path
      end
    end
    
    context 'ログイン後' do
      before { login_as(user) }
      context '一般ユーザー' do
        it 'ページにアクセスできないこと' do
          visit new_question_path
          expect(current_path).to eq root_path
        end
      end
      
      context 'アドミンユーザー' do
        before { login_as(admin) }
        it 'ページにアクセスできること' do
          visit new_question_path
          expect(page).to have_content '質問登録'
        end
      end
    end
  end
end