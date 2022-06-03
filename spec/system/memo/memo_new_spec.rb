require 'rails_helper'

RSpec.describe 'Memo#new', type: :system do
  describe 'メモ新規作成' do
    let(:user) { create(:user) }
    let(:question) { create(:question, category_id: user.category_id) }
    let(:training) { create(:training, user_id: user.id, question_id: question.id, title: question.title) }
    let(:point) { create(:voice, :point, training_id: training.id) }

    context 'ログイン前' do
      it 'ページにアクセスできないこと' do
        visit training_path(training.id)
        expect(page).to have_content 'ログインしてください'
        expect(page).to have_current_path login_path, ignore_query: true
      end
    end

    context 'ログイン後' do
      before do
        login_as(user)
        question
        training
        point
        visit question_path(question.id)
      end

      it 'ページにアクセスできること' do
        visit training_path(training.id)
        expect(page).to have_current_path training_path(training.id), ignore_query: true
      end

      it 'メモが表示されていること' do
        visit training_path(training.id)
        expect(page).to have_content 'メモ'
      end

      it 'メモを新規作成できること' do
        visit training_path(training.id)
        fill_in 'memo_body',	with: 'テストメモ'
        click_button '保存'
        expect(page).to have_content 'テストメモ'
      end
    end
  end
end
