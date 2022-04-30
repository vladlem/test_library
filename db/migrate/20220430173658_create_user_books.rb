class CreateUserBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :user_books do |t|
      t.integer :user_id, null: false
      t.integer :book_id, null: false
      t.string :reservation_status, limit: 255, null: false

      t.timestamps
    end
  end
end
