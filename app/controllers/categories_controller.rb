class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @questions = @category.questions.order(:id)
  end
end
