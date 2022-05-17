require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション確認' do
    let(:user) { create(:user) }

    it 'email, category_id, password, password_confirmationがあれば有効であること' do
      expect(user).to be_valid
    end

    it 'emailが無ければ無効であること' do
      user.email = nil
      expect(user).to be_invalid
    end

    it 'emailが重複している場合、無効であること' do
      other_user = build(:user, email: user.email)
      expect(other_user).to be_invalid
    end

    it 'emailが重複していない場合、有効であること' do
      other_user = build(:user)
      expect(other_user).to be_valid
    end

    it 'passwordが無ければ無効であること' do
      user = build(:user, password: nil)
      expect(user).to be_invalid
    end

    it 'password_confirmationが無ければ無効であること' do
      user = build(:user, password_confirmation: nil)
      expect(user).to be_invalid
    end
  end
end
