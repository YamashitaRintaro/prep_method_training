class TrainingsController < ApplicationController

  def new
    @training = Training.new
  end
  
  def create
    @training = current_user.trainings.new(training_params)
    @training.save!
  end

  private

  def training_params
    params.require(:training).permit(:user_id, :question_id, :title)
  end
end
