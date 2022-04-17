require 'rails_helper'

RSpec.describe "Training#show", type: :system do
  describe 'トレーニング詳細（録音画面）' do
    let(:user) { create(:user) }
    let(:question) { create(:question, category_id: user.category_id) }
    let(:training) { create(:training, user_id: user.id, question_id: question.id, title: question.title) }

    context 'ログイン前' do
      it 'ページにアクセスできないこと' do
        visit training_path(training.id)
        expect(page).to have_content 'ログインしてください'
        expect(current_path).to eq login_path
      end
    end
    
    context 'ログイン後' do
      before { login_as(user) }
      it 'ページにアクセスできること' do
        visit training_path(training.id)
        expect(current_path).to eq training_path(training.id)
      end

      it '質問のタイトルが表示されていること' do
        visit training_path(training.id)
        expect(page).to have_content question.title
      end

      context "録音スタートボタンを押したら" do
        before do
          visit training_path(training.id)
        end

        fit '結論フェーズの録音が始まること', js: true do   
          # click_button '録音スタート'
          find('.record').click
          binding.pry
          expect(page).to have_button '理由フェーズへ'
        end

        it '結論フェーズ後に理由フェーズの録音が始まること', js: true do
          find(".record").trigger('click')
          sleep question.question_voice_data_seconds
          click_button '理由フェーズへ'
          expect(page).to have_content '具体例フェーズへ'
        end
        
        it '理由フェーズ後に具体例フェーズの録音が始まること', js: true do
          find(".record").click()
          click_button '理由フェーズへ'
          click_button '具体例フェーズへ'
          expect(page).to have_content '結論フェーズへ'
        end

        it '具体例フェーズ後に結論フェーズの録音が始まること', js: true do
          find(".record").click
          click_button '理由フェーズへ'
          click_button '具体例フェーズへ'
          click_button '結論フェーズへ'
          expect(page).to have_content '保存'
        end

        it '保存ボタンを押すと、question_showページに遷移すること', js: true do
          find(".record").click
          click_button '理由フェーズへ'
          click_button '具体例フェーズへ'
          click_button '結論フェーズへ'
          click_button '保存'
          expect(current_path).to eq question_path(question.id)
          expect(page).to have_content question.title
        end
      end
    end
  end
end