class VoicesController < ApplicationController
  before_action :current_user_training, only: %i[new]

  def new
    @question = @training.question
    @question_title = @training.question.title
    @question_voice_data = @training.question.question_voice_data
    @question_voice_data_seconds = @training.question.question_voice_data_seconds
  end
  
  def create
    @voice = Voice.new(voice_params)
    @voice.save!
  end

  private

  def current_user_training
    @training = current_user.trainings.find(params[:training_id])
  end

  def voice_params
    params.permit(:training_id, :phase, :voice_data)
  end
end
