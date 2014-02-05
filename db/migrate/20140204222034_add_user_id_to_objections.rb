class AddUserIdToObjections < ActiveRecord::Migration
  def change
    add_column :objections, :user_id, :integer
  end
end
