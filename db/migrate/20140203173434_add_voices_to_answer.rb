class AddVoicesToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :voices, :integer
  end
end
