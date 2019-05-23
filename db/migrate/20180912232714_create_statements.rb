class CreateStatements < ActiveRecord::Migration[5.2]
  def change
    create_table :statements do |t|
    	t.string :query
    	t.string :category

      t.timestamps
    end
  end
end
