class TrainingsController < ApplicationController
  before_action :current_user_training, only: %i[show]

  def new
    @training = Training.new
    @questions = Question.where(category_id: current_user.category_id).order(:id)
  end

  def create
    @training = current_user.trainings.new(training_params)
    if @training.save
      redirect_to training_path(@training)
    else
      flash.now[:danger] = t('.fail')
      redirect_back fallback_location: root_path
    end
  end

  def show
    @question = @training.question
    @question_title = @training.question.title
    @question_voice_data = @training.question.question_voice_data
    @question_voice_data_seconds = @training.question.question_voice_data_seconds
  end

  private

  def current_user_training
    @training = current_user.trainings.find(params[:id])
  end

  def training_params
    params.require(:training).permit(:user_id, :question_id, :title)
  end
end
