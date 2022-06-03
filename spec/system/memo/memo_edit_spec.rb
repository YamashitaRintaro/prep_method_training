require 'rails_helper'

RSpec.describe 'Memo#show', type: :system do
  describe 'メモ編集' do
    let(:user) { create(:user) }
    let(:question) { create(:question, category_id: user.category_id) }
    let(:training) { create(:training, user_id: user.id, question_id: question.id, title: question.title) }
    let(:point) { create(:voice, :point, training_id: training.id) }
    let(:memo) { create(:memo, training_id: training.id) }

    context 'ログイン前' do
      it 'ページにアクセスできないこと' do
        visit edit_training_memo_path(training.id, memo.id)
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
      end

      it 'ページにアクセスできること' do
        visit edit_training_memo_path(training.id, memo.id)
        expect(page).to have_current_path edit_training_memo_path(training.id, memo.id), ignore_query: true
      end

      it 'メモを編集できること' do
        visit edit_training_memo_path(training.id, memo.id)
        fill_in 'js-new-memo-body',	with: 'テスト'
        click_button '保存'
        expect(page).to have_content 'テスト'
      end
    end
  end
end
