require 'rails_helper'

RSpec.describe "Questions", type: :system do

  describe '質問詳細画面' do
    let(:user) { create(:user) }
    let(:question) { create(:question) }

    context 'ログイン前' do
      it 'ページにアクセスできないこと' do
        visit new_question_path
        expect(page).to have_content 'please login first'
        expect(current_path).to eq login_path
      end
    end

    context 'ログイン後' do
      before { login_as(user) }
      fit 'ページにアクセスできること' do
        question
        visit category_path(user.category_id)
        expect(page).to have_content question.title
      end
    end
  end
end