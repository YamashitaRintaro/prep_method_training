class ChangeColoumnsNotnullOnUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :category_id, false
  end
end
