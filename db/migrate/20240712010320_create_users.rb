class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 100
      t.string :email, null: false, limit: 254
      t.string :password_digest, null: false, limit: 128

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
