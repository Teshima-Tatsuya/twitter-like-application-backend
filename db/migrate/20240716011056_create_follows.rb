class CreateFollows < ActiveRecord::Migration[7.1]
  def change
    create_table :follows do |t|
      t.references :following_user, null: false, foreign_key: { to_table: :users }
      t.references :follower_user, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :follows, [:following_user_id, :follower_user_id], unique: true
  end
end
