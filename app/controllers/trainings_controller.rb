class TrainingsController < ApplicationController
  def new
    @training = Training.new
    @questions = case current_user.category_id
                 when 1
                   Question.where(category_id: 1).order(:id)
                 when 2
                   Question.where(category_id: 2).order(:id)
                 else
                   Question.where(category_id: 3).order(:id)
                 end
  end

  def create
    @training = current_user.trainings.new(training_params)
    if @training.save
      redirect_to training_path(@training)
    else
      flash.now[:danger] = '質問を選択してください'
      redirect_back fallback_location: root_path
    end
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
