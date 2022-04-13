require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:category) { create(:category1) }

  describe 'ユーザー新規登録' do
    context 'フォームの入力値が正常' do
      it 'ユーザーの新規作成が成功する' do
        visit new_user_path
        fill_in 'メールアドレス', with: "exam@example.com"
        choose '新卒' #なぜか選択できないため、保留
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録する'
        expect(page).to have_checked_field('新卒')
        expect(page).to have_content 'ユーザー登録しました'
        expect(current_path).to eq login_path
      end
    end

    context 'メールアドレスが未入力' do
      it 'ユーザーの新規作成が失敗する' do
        visit new_user_path
        fill_in 'メールアドレス', with: ''
        choose '新卒'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録する'
        expect(page).to have_content "メールアドレスを入力してください"
        expect(current_path).to eq users_path
      end
    end

    context '登録済のメールアドレスを使用' do
      it 'ユーザーの新規作成が失敗する' do
        existed_user = create(:user)
        visit new_user_path
        fill_in 'メールアドレス', with: existed_user.email
        choose '新卒'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録する'
        expect(page).to have_content 'メールアドレスはすでに存在します'
        expect(current_path).to eq users_path
        expect(page).to have_field 'メールアドレス', with: existed_user.email
      end
    end

    context 'category_idが未入力' do
      it 'ユーザーの新規作成が失敗する' do
        visit new_user_path
        fill_in 'メールアドレス', with: "exam2@example.com"
        choose '新卒'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録する'
        expect(page).to have_content '面接シーンを入力してください'
        expect(current_path).to eq users_path
        expect(page).to have_field 'メールアドレス', with: "exam2@example.com"
      end
    end

    context 'パスワードが未入力' do
      it 'ユーザーの新規作成が失敗する' do
        visit new_user_path
        fill_in 'メールアドレス', with: "exam@example.com"
        choose '新卒'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録する'
        expect(page).to have_content 'パスワードを入力してください'
        expect(current_path).to eq users_path
        expect(page).to have_field 'メールアドレス', with: "exam@example.com"
      end
    end

    context 'パスワード確認が未入力' do
      it 'ユーザーの新規作成が失敗する' do
        visit new_user_path
        fill_in 'メールアドレス', with: "exam@example.com"
        choose '新卒'
        fill_in 'パスワード', with: 'password'
        click_button '登録する'
        expect(page).to have_content 'パスワード確認を入力してください'
        expect(current_path).to eq users_path
        expect(page).to have_field 'メールアドレス', with: "exam@example.com"
      end
    end
  end
end
