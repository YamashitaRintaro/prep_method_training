class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  def new
    return redirect_to root_path, info: t('defaults.message.logged_in') if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: 'ユーザー登録しました'
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :category_id, :password, :password_confirmation)
  end
end
