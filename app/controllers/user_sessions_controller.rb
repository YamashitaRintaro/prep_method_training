class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create guest_login]
  skip_before_action :require_category_id
  def new
    # ログイン済みユーザーの場合はログイン画面を表示しない
    logged_in
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to new_training_path
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def destroy
    current_user.destroy! if current_user.guest?
    logout
    redirect_to root_path, success: t('.success')
  end

  def guest_login
    logged_in and return

    random_value = SecureRandom.hex
    user = User.create!(email: "guest_#{random_value}@example.com", role: :guest, category_id: 1, password: random_value, password_confirmation: random_value)
    auto_login(user)
    redirect_to new_training_path
  end
end
