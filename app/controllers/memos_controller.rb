class MemosController < ApplicationController
  def create
    @memo = Memo.new(memo_params)
    binding.pry
    if @memo.save
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path, danger: t('defaults.message.not_created', item: Memo.model_name.human)
    end
  end

  def update
  end

  def destroy
  end
  
  private

  def memo_params
    params.require(:memo).permit(:body).merge(training_id: params[:training_id])
  end
end
