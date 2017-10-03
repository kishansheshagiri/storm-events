class CreateUsStates < ActiveRecord::Migration[5.1]
  def change
    create_table :us_states, id: false do |t|
      t.integer :id, unsigned: true, null: false, primary_key: true
      t.string :name, limit: 30, null: false
      t.string :short_code, limit: 2

      t.timestamps
    end
  end
end
