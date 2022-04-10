class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]
  before_action :require_admin, only: [:index, :create, :edit]

  def index
    @question = Question.all.order(:category_id, :id)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to questions_path
    else
      render :index
    end
  end

  def show
    @question = Question.find(params[:id])
    @trainings = @question.trainings.order("id")
    @voices = Question.includes(trainings: :voices).order("id")
  end

  def edit;end

  def update
    if @question.update(question_params)
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:category_id, :title, :question_voice_data, :question_voice_data_seconds)
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end
