class VoicesController < ApplicationController

  def create
    @voice = Voice.new(voice_params)
    @voice.save!
  end

  private

  def voice_params
    params.require(:voice).permit(:training_id, :phase, :voice_data)
  end
end
