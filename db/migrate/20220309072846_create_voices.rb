class CreateVoices < ActiveRecord::Migration[6.1]
  def change
    create_table :voices do |t|
      t.references :training, null: false
      t.string :voice_data, null: false
      t.integer :phase, null: false, default: 0

      t.timestamps
    end
  end
end
