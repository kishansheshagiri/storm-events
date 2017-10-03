class CreateForecastOffices < ActiveRecord::Migration[5.1]
  def change
    create_table :forecast_offices, id: false do |t|
      t.string :id, limit: 3, null: false
      t.string :name, limit: 35, null: false
      t.integer :us_state_id, unsigned: true

      t.timestamps
    end

    add_foreign_key :forecast_offices, :us_states
  end
end
