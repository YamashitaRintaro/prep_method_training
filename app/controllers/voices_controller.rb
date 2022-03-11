class VoicesController < ApplicationController

  def create
    @voice = Voice.new(voice_params)
    @voice.save!
    redirect_to root_path
  end

  private

  def voice_params
    params.require(:voice).permit(:training_id, :phase, :voice_data)
  end
end
