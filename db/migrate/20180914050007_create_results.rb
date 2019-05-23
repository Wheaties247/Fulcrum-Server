class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
    	t.boolean :crown
    	t.boolean :third
    	t.boolean :power
    	t.boolean :throat
    	t.boolean :navel
    	t.boolean :root
    	t.boolean :heart
    	t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
