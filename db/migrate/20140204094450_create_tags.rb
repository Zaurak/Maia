class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :user_id
      t.integer :debate_id
      t.integer :voices

      t.timestamps
    end
  end
end
