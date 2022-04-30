class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name, limit: 255, null: false
      t.string :author, limit: 255, null: false

      t.timestamps
    end
  end
end
