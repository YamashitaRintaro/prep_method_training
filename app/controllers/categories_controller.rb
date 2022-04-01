class CategoriesController < ApplicationController
  before_action :set_category, only: %i[edit update]
  before_action :if_not_admin, only: %i[edit update]

  def show
    @category = Category.find(params[:id])
    @questions = @category.questions.order(:id)
  end

  def edit;end

  def update
    if @category.update(category_params)
      redirect_to categories_path
    else
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end

end
