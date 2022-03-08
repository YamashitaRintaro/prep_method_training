class TrainingsController < ApplicationController

  
  def create
    @training = current_user.trainings.new(training_params)
    if @training.save
      redirect_to root_path
    else
      flash.now[:danger] = '質問を選択してください'
      redirect_back fallback_location: root_path
    end
  end
  
  def new_graduate
    @questions = Question.where(category_id: 1)
    @training = Training.new
  end
  
  def job_change
    @questions = Question.where(category_id: 2)
    @training = Training.new
  end
  
  def engineer
    @questions = Question.where(category_id: 3)
    @training = Training.new
  end
  
  private
  
  def training_params
    params.require(:training).permit(:user_id, :question_id, :title)
  end
end
