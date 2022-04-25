require 'rails_helper'

RSpec.describe 'Question#edit', type: :system do
  describe '質問編集' do
    let(:user) { create(:user) }
    let(:admin) { create(:user, :admin) }
    let(:category) { create(:category) }
    let(:question) { create(:question, category_id: user.category_id) }

    context 'ログイン前' do
      it 'ページにアクセスできないこと' do
        visit edit_question_path(question.id)
        expect(page).to have_content 'ログインしてください'
        expect(page).to have_current_path login_path, ignore_query: true
      end
    end

    context 'ログイン後' do
      before { login_as(user) }

      context '一般ユーザー' do
        it 'ページにアクセスできないこと' do
          visit edit_question_path(question.id)
          expect(page).to have_current_path root_path, ignore_query: true
        end
      end

      context 'アドミンユーザー' do
        before { login_as(admin) }

        it 'ページにアクセスできること' do
          visit edit_question_path(question.id)
          expect(page).to have_content '質問登録'
          expect(page).to have_current_path edit_question_path(question.id), ignore_query: true
        end

        context '正常系' do
          it 'category_idを編集できること' do
            visit edit_question_path(question.id)
            fill_in 'Category',	with: category.id
            click_button '登録'
            expect(page).to have_content '質問一覧'
            expect(page).to have_content category.id
            expect(page).to have_current_path questions_path, ignore_query: true
          end

          it 'titleを編集できること' do
            visit edit_question_path(question.id)
            fill_in 'Title',	with: '自己PRをしてください'
            click_button '登録'
            expect(page).to have_content '質問一覧'
            expect(page).to have_content '自己PRをしてください'
            expect(page).to have_current_path questions_path, ignore_query: true
          end

          it 'question_voice_dataを編集できること' do
            visit edit_question_path(question.id)
            attach_file 'Question voice data', "#{Rails.root}/spec/fixtures/question24.wav"
            click_button '登録'
            expect(page).to have_content 'question24.wav'
            expect(page).to have_current_path questions_path, ignore_query: true
          end

          it 'question_voice_data_secondsを編集できること' do
            visit edit_question_path(question.id)
            fill_in 'Question voice data seconds',	with: 5
            click_button '登録'
            expect(page).to have_content '5'
            expect(page).to have_current_path questions_path, ignore_query: true
          end
        end
      end
    end
  end
end
