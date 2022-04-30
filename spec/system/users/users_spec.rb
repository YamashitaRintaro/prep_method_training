require 'rails_helper'

RSpec.describe 'Users', type: :system do
  fdescribe 'ユーザー新規登録' do
    let!(:category) { create(:category, :category2) }

    context 'フォームの入力値が正常' do
      it 'ユーザーの新規作成が成功する' do
        visit new_user_path
        fill_in 'メールアドレス', with: 'exam@example.com'
        choose '転職' # category_id: 1はすでにロールバックで削除されているため、選択できない。手動でテストを行う
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録する'
        expect(page).to have_content 'ユーザー登録しました'
        expect(page).to have_current_path login_path, ignore_query: true
      end
    end

    context 'メールアドレスが未入力' do
      it 'ユーザーの新規作成が失敗する' do
        visit new_user_path
        choose '転職'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録する'
        expect(page).to have_content 'メールアドレスを入力してください'
        expect(page).to have_current_path users_path, ignore_query: true
      end
    end

    context '登録済のメールアドレスを使用' do
      it 'ユーザーの新規作成が失敗する' do
        existed_user = create(:user)
        visit new_user_path
        fill_in 'メールアドレス', with: existed_user.email
        choose '転職'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録する'
        expect(page).to have_content 'メールアドレスはすでに存在します'
        expect(page).to have_current_path users_path, ignore_query: true
        expect(page).to have_field 'メールアドレス', with: existed_user.email
      end
    end

    context 'category_idが未入力' do
      it 'ユーザーの新規作成が失敗する' do
        visit new_user_path
        fill_in 'メールアドレス', with: 'exam2@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録する'
        expect(page).to have_content '面接シーンを入力してください'
        expect(page).to have_current_path users_path, ignore_query: true
        expect(page).to have_field 'メールアドレス', with: 'exam2@example.com'
      end
    end

    context 'パスワードが未入力' do
      it 'ユーザーの新規作成が失敗する' do
        visit new_user_path
        fill_in 'メールアドレス', with: 'exam@example.com'
        choose '転職'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録する'
        expect(page).to have_content 'パスワードを入力してください'
        expect(page).to have_current_path users_path, ignore_query: true
        expect(page).to have_field 'メールアドレス', with: 'exam@example.com'
      end
    end

    context 'パスワード確認が未入力' do
      it 'ユーザーの新規作成が失敗する' do
        visit new_user_path
        fill_in 'メールアドレス', with: 'exam@example.com'
        choose '転職'
        fill_in 'パスワード', with: 'password'
        click_button '登録する'
        expect(page).to have_content 'パスワード確認を入力してください'
        expect(page).to have_current_path users_path, ignore_query: true
        expect(page).to have_field 'メールアドレス', with: 'exam@example.com'
      end
    end
  end
end
