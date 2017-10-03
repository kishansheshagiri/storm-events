class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events, id: false do |t|
      t.integer :id, unsigned: true, null: false, primary_key: true
      t.string :storm_type, limit: 50
      t.datetime :begin_time
      t.datetime :end_time
      t.integer :state_fips
      t.integer :county_fips
      t.string :source, limit: 30, null: false
      t.string :forecast_office, limit: 3
      t.float :magnitude
      t.string :magnitude_type, limit: 2
      t.float :property_damage
      t.float :crop_damage
      t.string :narrative, limit: 5000
      t.integer :episode_id, unsigned: true, null: false

      t.timestamps
    end

    add_foreign_key :events, :episodes
  end
end
