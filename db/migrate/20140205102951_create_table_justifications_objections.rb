class CreateTableJustificationsObjections < ActiveRecord::Migration
  def change
    create_table :table_justifications_objections, id: false do |t|
    	t.references :justification
    	t.references :objection 

    	t.timestamps
    end
  end
end
