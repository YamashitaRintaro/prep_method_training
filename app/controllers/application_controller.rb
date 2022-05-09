class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :require_category_id

  add_flash_types :success, :info, :warning, :danger

  private

  def not_authenticated
    redirect_to login_path, danger: t('defaults.message.require_login')
  end

  def logged_in
    redirect_to root_path, danger: t('defaults.message.logged_in') if logged_in?
  end

  def require_category_id
    redirect_to edit_user_category_path, danger: t('defaults.message.require_category') if current_user.category_id.blank?
  end
end
