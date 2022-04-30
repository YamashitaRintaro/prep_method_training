class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  def new
    # ログイン済みユーザーの場合は新規登録画面を表示しない
    logged_in
    @user = User.new
    @category = Category.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :category_id, :password, :password_confirmation)
  end
end
