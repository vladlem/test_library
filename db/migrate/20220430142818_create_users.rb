class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username, limit: 255, null: false
      t.string :email, limit: 255, null: false
      t.string :user_type, limit: 255, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
