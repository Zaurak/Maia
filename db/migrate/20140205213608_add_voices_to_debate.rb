class AddVoicesToDebate < ActiveRecord::Migration
  def change
    add_column :debates, :voices, :integer
  end
end
