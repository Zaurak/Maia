class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :clarity
      t.integer :usefulness
      t.integer :completness
      t.integer :user_id
      t.integer :debate_id,         default: -1
      t.integer :answer_id,         default: -1
      t.integer :tag_id,            default: -1
      t.integer :justification_id,  default: -1
      t.integer :objection_id,      default: -1

      t.timestamps
    end
  end
end
