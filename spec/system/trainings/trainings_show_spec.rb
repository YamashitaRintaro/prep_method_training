require 'rails_helper'

RSpec.describe 'Training#show', type: :system do
  describe 'トレーニング詳細（録音画面）' do
    let(:user) { create(:user) }
    let(:question) { create(:question, category_id: user.category_id) }
    let(:training) { create(:training, user_id: user.id, question_id: question.id, title: question.title) }
    let(:point) { create(:voice, :point, training_id: training.id) }
    let(:reason) { create(:voice, :reason, training_id: training.id) }
    let(:example) { create(:voice, :example, training_id: training.id) }
    let(:second_point) { create(:voice, :second_point, training_id: training.id) }

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
        reason
        example
        second_point
        visit question_path(question.id)
      end

      it 'ページにアクセスできること' do
        visit training_path(training.id)
        expect(page).to have_current_path training_path(training.id), ignore_query: true
      end

      it '質問のタイトルが表示されていること' do
        visit training_path(training.id)
        expect(page).to have_content question.title
      end

      it '音声が表示されていること', js: true do
        visit training_path(training.id)
        expect(page).to have_content '結論'
        expect(page).to have_content '理由'
        expect(page).to have_content '具体例'
        expect(page).to have_content '結論'
      end

      it 'メモが表示されていること' do
        visit training_path(training.id)
        expect(page).to have_content 'メモ'
      end
    end
  end
end
