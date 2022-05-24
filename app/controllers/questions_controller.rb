class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]
  before_action :require_admin, except: %i[index show]

  def index
    @training = Training.new
    @questions = Question.where(category_id: current_user.category_id).order(:id)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to admin_questions_path, success: t('defaults.message.created', item: Question.model_name.human)
    else
      render :new
    end
  end

  def show
    @trainings = @question.trainings.order('id')
    @current_user_trainings = @trainings.where(user_id: current_user.id)
  end

  def edit; end

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
