class AddQuestionVoiceSecondsToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :question_voice_data_seconds, :integer
  end
end
