class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.integer :event_id, unsigned: true, null: false
      t.integer :location_index, limit: 1
      t.float :loc_range
      t.string :azimuth, limit: 3
      t.string :location, limit: 50
      t.float :latitude
      t.float :longitude

      t.timestamps
    end

    add_foreign_key :locations, :events
  end
end
