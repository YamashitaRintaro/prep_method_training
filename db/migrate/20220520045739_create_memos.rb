class CreateMemos < ActiveRecord::Migration[6.1]
  def change
    create_table :memos do |t|
      t.text :body, null: false
      t.references :training, null: false, foreign_key: true

      t.timestamps
    end
  end
end
