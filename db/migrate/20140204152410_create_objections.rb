class CreateObjections < ActiveRecord::Migration
  def change
    create_table :objections do |t|
      t.string  :name
      t.integer :voices
      t.integer :debate_id, default: -1
      t.integer :answer_id, default: -1
      t.string  :justification_id, default: -1
      t.string  :tag_id, default: -1

      t.timestamps
    end
  end
end
