class ChangeAllownullToUsers < ActiveRecord::Migration[6.1]
  def up
    change_column_null :users, :category_id, true
  end

  def down
    change_column_null :users, :category_id, false
  end
end
