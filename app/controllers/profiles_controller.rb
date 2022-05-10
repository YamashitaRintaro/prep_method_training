class ProfilesController < ApplicationController
  before_action :set_user
  before_action :category_all, only: %i[edit update]
  skip_before_action :require_category_id

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: t('defaults.message.updated', item: User.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: User.model_name.human)
      render :edit
    end
  end

  def show
    @category = current_user.category.name if current_user.category_id.present?
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def category_all
    @category = Category.all
  end

  def user_params
    params.require(:user).permit(:email, :category_id)
  end
end
