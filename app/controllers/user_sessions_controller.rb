class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create guest_login]
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to new_training_path
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    current_user.destroy! if current_user.guest?
    logout
    redirect_to root_path, success: 'ログアウトしました'
  end

  def guest_login
    redirect_to root_path, alert: 'すでにログインしています' if current_user # ログインしてる場合はユーザーを作成しない

    random_value = SecureRandom.hex
    user = User.create!(email: "guest_#{random_value}@example.com", role: :guest, category_id: 1, password: random_value, password_confirmation: random_value)
    auto_login(user)
    redirect_to new_training_path
  end
end
