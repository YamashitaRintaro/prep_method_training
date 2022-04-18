require 'rails_helper'

RSpec.describe "Training#new", type: :system do
  describe 'トレーニング新規追加' do
    let(:user) { create(:user) }
    let(:question) { create(:question, category_id: user.category_id) }

    context 'ログイン前' do
      it 'ページにアクセスできないこと' do
        visit new_training_path
        expect(page).to have_content 'ログインしてください'
        expect(current_path).to eq login_path
      end
    end
    
    context 'ログイン後' do
      before { login_as(user) }
      it 'ページにアクセスできること' do
        visit new_training_path
        expect(page).to have_content '質問を選択してください'
      end

      # context "正常系" do          
      #   it '新規追加できること' do  すでにcategory_id: 1~3はトランザクションで削除されているため、質問を画面に表示できない
      #     question
      #     visit new_training_path
      #     choose question.title
      #     click_button '次へ'
      #     expect(page).to have_content question.title
      #     expect(page).to have_content '録音スタート'
      #   end
      # end
    end
  end
end