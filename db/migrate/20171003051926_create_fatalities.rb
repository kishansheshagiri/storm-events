class CreateFatalities < ActiveRecord::Migration[5.1]
  def change
    create_table :fatalities, id: false do |t|
      t.integer :id, unsigned: true, null:false, primary_key: true
      t.date :fatality_date
      t.integer :age, limit: 1
      t.string :sex, limit: 1
      t.string :location, limit: 40
      t.integer :event_id, unsigned: true

      t.timestamps
    end

    add_foreign_key :fatalities, :events
  end
end
