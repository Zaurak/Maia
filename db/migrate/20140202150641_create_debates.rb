class CreateDebates < ActiveRecord::Migration
  def change
    create_table :debates do |t|
      t.string :description
      t.integer :user_id

      t.timestamps
    end
  end
end
