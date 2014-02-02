class CreateUsersRelationships < ActiveRecord::Migration
  def change
    create_table :users_relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :users_relationships, :follower_id
    add_index :users_relationships, :followed_id
    add_index :users_relationships, [:follower_id, :followed_id], unique: true
  end
end
