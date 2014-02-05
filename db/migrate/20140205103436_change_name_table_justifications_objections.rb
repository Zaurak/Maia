class ChangeNameTableJustificationsObjections < ActiveRecord::Migration
  def change
  	rename_table :table_justifications_objections, :justifications_objections
  end
end
