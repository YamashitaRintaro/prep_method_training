class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.references :category, null: false
      t.string :title, null: false
      t.string :question_voice_data

      t.timestamps
    end
  end
end
