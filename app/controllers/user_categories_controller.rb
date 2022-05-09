class UserCategoriesController < ApplicationController
  before_action :set_user
  skip_before_action :require_category_id

  def edit
   @category = Category.all
  end

  def update
    @category = Category.all
    if @user.update(user_params)
      redirect_to new_training_path, success: t('defaults.message.updated', item: User.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: User.model_name.human)
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:category_id)
  end
end
