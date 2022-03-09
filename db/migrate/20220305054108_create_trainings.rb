class CreateTrainings < ActiveRecord::Migration[6.1]
  def change
    create_table :trainings do |t|
      t.references :user, null: false
      t.references :question, null: false
      t.string :title, null: false

      t.timestamps
    end
  end
end
