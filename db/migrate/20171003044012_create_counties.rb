class CreateCounties < ActiveRecord::Migration[5.0]
  def change
    create_table :counties do |t|
      t.integer :fips, unsigned: true, null: false
      t.integer :us_state_id, unsigned: true, null: false
      t.string :name, limit: 30
      t.string :timezone, limit: 6

      t.timestamps
    end

    add_foreign_key :counties, :us_states
  end
end
