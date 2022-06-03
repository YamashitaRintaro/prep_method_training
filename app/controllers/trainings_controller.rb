class TrainingsController < ApplicationController
  before_action :current_user_training, only: %i[show]

  def create
    @training = current_user.trainings.new(training_params)
    if @training.save
      redirect_to new_training_voice_path(@training)
    else
      flash.now[:danger] = t('.fail')
      redirect_back fallback_location: root_path
    end
  end

  def show
    @voices = @training.voices.order('id')
    @question = @training.question
    @question_title = @training.question.title
    @memo = Memo.new
    @memos = @training.memo
  end

  private

  def current_user_training
    @training = current_user.trainings.find(params[:id])
  end

  def training_params
    params.require(:training).permit(:user_id, :question_id, :title)
  end
end
