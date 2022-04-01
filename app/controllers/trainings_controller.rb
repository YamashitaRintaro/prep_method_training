class TrainingsController < ApplicationController
  
  def create
    @training = current_user.trainings.new(training_params)
    if @training.save
      redirect_to training_path(@training)
    else
      flash.now[:danger] = '質問を選択してください'
      redirect_back fallback_location: root_path
    end
  end
  
  def new_graduate
    @questions = Question.where(category_id: 1).order(:id)
    @training = Training.new
  end
  
  def job_change
    @questions = Question.where(category_id: 2).order(:id)
    @training = Training.new
  end
  
  def engineer
    @questions = Question.where(category_id: 3).order(:id)
    @training = Training.new
  end

  def show
    @training = current_user.trainings.find(params[:id])
    @question = @training.question
    @question_title = @training.question.title
    @question_voice_data = @training.question.question_voice_data
    @question_voice_data_seconds = @training.question.question_voice_data_seconds
  end

  def destroy
    @training = current_user.trainings.find(params[:id])
    @training.destroy!
    redirect_back fallback_location: root_path
  end
  
  
  private
  
  def training_params
    params.require(:training).permit(:user_id, :question_id, :title)
  end
end
