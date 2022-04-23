require 'rails_helper'

RSpec.describe "Admin", type: :system do
  describe '管理画面' do
    let(:user) { create(:user) }
    let(:admin) { create(:user, :admin) }

    context 'ログイン前' do
      it 'ページにアクセスできないこと' do
        visit admin_root_path
        expect(current_path).to eq root_path
      end
    end
    
    context 'ログイン後' do
      before { login_as(user) }
      context '一般ユーザー' do
        it 'ページにアクセスできないこと' do
          visit admin_root_path
          expect(current_path).to eq root_path
        end
      end
      
      context 'アドミンユーザー' do
        before { login_as(admin) }
        it 'ページにアクセスできること' do
          visit admin_root_path
          expect(current_path).to eq admin_root_path
          expect(page).to have_content 'アプリに戻る'
        end 
      end
    end
  end
end