class CreateLists < ActiveRecord::Migration[7.1]
  def change
    create_table :lists do |t|
      t.string :title, null: false
      t.string :content, null: false

      t.timestamps
    end
  end
end
