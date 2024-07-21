class RemoveListTitle < ActiveRecord::Migration[7.1]
  def change
    remove_column :lists, :title, :string
  end
end
