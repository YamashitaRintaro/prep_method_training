class ChangeColumnsNotnullAddCategories < ActiveRecord::Migration[6.1]
  def change
    change_column :categories, :name, :string, null: false
  end
end
