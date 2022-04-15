require 'rails_helper'

RSpec.describe "Question#new", type: :system do
  describe '質問新規追加' do
    let(:user) { create(:user) }
    let(:admin) { create(:user, :admin) }

    context 'ログイン前' do
      it 'ページにアクセスできないこと' do
        visit new_question_path
        expect(page).to have_content 'ログインしてください'
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

        context "正常系" do          
          it '新規追加できること' do
            visit new_question_path
            fill_in "Category",	with: user.category_id 
            fill_in "Title",	with: "自己紹介をしてください"
            attach_file "Question voice data", "#{Rails.root}/spec/fixtures/question1.wav"
            fill_in "Question voice data seconds",	with: 2
            click_button '登録'
            expect(page).to have_content '質問を作成しました'
          end
        end

        context "異常系" do
          context "category_idが未入力" do          
            it '新規追加できないこと' do
              visit new_question_path
              fill_in "Title",	with: "自己紹介をしてください"
              attach_file "Question voice data", "#{Rails.root}/spec/fixtures/question1.wav"
              fill_in "Question voice data seconds",	with: 2
              click_button '登録'
              expect(page).to have_content 'Categoryを入力してください'
            end
          end

          context "titleが未入力" do          
            it '新規追加できないこと' do
              visit new_question_path
              fill_in "Category",	with: user.category_id 
              attach_file "Question voice data", "#{Rails.root}/spec/fixtures/question1.wav"
              fill_in "Question voice data seconds",	with: 2
              click_button '登録'
              expect(page).to have_content 'Titleを入力してください'
            end
          end
        end 
      end
    end
  end
end