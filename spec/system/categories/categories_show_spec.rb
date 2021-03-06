require 'rails_helper'

RSpec.describe 'Category#show', type: :system do
  describe 'カテゴリー詳細画面' do
    let(:user) { create(:user) }
    let(:category) { create(:category, :category2) }
    let(:question) { create(:question, category_id: user.category_id) }
    let(:question_category2) { create(:question, :question_category2, category_id: category.id) }

    context 'ログイン前' do
      it 'ページにアクセスできないこと' do
        visit category_path(user.category_id)
        expect(page).to have_content 'ログインしてください'
        expect(page).to have_current_path login_path, ignore_query: true
      end
    end

    context 'ログイン後' do
      before { login_as(user) }

      it 'ページにアクセスできること' do
        question
        visit category_path(user.category_id)
        expect(page).to have_content question.title
      end

      it '選択したカテゴリー以外の質問は表示されないこと' do
        question
        question_category2
        visit category_path(user.category_id)
        expect(page).to have_content question.title
        expect(page).not_to have_content question_category2.title
      end
    end
  end
end
