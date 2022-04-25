require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'reset_password_email' do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.reset_password_email(user) }
    # Sorceryのgenerate_reset_password_token!メソッドでトークンを発行

    before { user.generate_reset_password_token! }

    it 'ヘッダー情報・ボディ情報が正しいこと' do
      # メールを送信して、メールの件数が1件増えることを確認
      expect do
        mail.deliver_now
      end.to change { ActionMailer::Base.deliveries.size }.by(1)
      expect(mail.subject).to eq('パスワードリセット')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['from@example.com'])
    end
  end
end
