class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :debate_id
      t.text :content

      t.timestamps
    end
  end
end
