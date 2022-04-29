require 'rails_helper'

RSpec.describe 'Question#show', type: :system do
  describe '質問詳細' do
    let(:user) { create(:user) }
    let(:question) { create(:question, category_id: user.category_id) }
    let(:training) { create(:training, user_id: user.id, question_id: question.id, title: question.title) }
    let(:point) { create(:voice, :point, training_id: training.id) }
    let(:reason) { create(:voice, :reason, training_id: training.id) }
    let(:example) { create(:voice, :example, training_id: training.id) }
    let(:second_point) { create(:voice, :second_point, training_id: training.id) }

    context 'ログイン前' do
      it 'ページにアクセスできないこと' do
        visit question_path(question.id)
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
        expect(page).to have_content '練習内容を振り返りましょう'
        expect(page).to have_content question.title
      end

      it '練習が表示されていること' do
        expect(page).to have_content '1回目の練習'
      end

      context 'アコーディオン' do
        it 'クリックすると音声が表示されること', js: true do
          find('.accordion-title').click
          expect(page).to have_content '結論'
          expect(page).to have_content '理由'
          expect(page).to have_content '具体例'
          expect(page).to have_content '結論'
        end

        it 'クリックしないと音声が表示されないこと', js: true do
          expect(page).not_to have_content '結論'
          expect(page).not_to have_content '理由'
          expect(page).not_to have_content '具体例'
          expect(page).not_to have_content '結論'
        end
      end
    end
  end
end
