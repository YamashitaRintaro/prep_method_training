class ApplicationController < ActionController::Base
  before_action :require_login

  add_flash_types :success, :info, :warning, :danger

  private

  def not_authenticated
    redirect_to login_path, danger: 'ログインしてください'
  end

  def logged_in
    redirect_to root_path, danger: t("defaults.message.logged_in") if logged_in?
  end
end
