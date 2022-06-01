class MemosController < ApplicationController
  before_action :set_memo, only: %i[edit update]

  def create
    @memo = Memo.new(memo_params)
    if @memo.save
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path, danger: t('defaults.message.not_created', item: Memo.model_name.human)
    end
  end

  def edit;end
  
  def update
    if @memo.update(memo_params)
      redirect_to training_path(@training)
    else
      render :edit
    end
  end
  
  private

  def memo_params
    params.require(:memo).permit(:body).merge(training_id: params[:training_id])
  end

  def set_memo
    @memo = Memo.find(params[:id])
    @training = @memo.training
  end
end
