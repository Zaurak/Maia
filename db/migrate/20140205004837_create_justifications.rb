class CreateJustifications < ActiveRecord::Migration
  def change
    create_table :justifications do |t|
      t.string :name
      t.string :content
      t.integer :voices
      t.integer :user_id
      t.integer :debate_id,     default: -1
      t.integer :answer_id,     default: -1
      t.integer :objection_id,  default: -1
      t.integer :tag_id,        default: -1

      t.timestamps
    end
  end
end
