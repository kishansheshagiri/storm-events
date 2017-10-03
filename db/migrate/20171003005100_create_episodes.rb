class CreateEpisodes < ActiveRecord::Migration[5.1]
  def change
    create_table :episodes, id: false do |t|
      t.integer :id, unsigned: true, null: false, primary_key: true 
      t.string :description, limit: 10000

      t.timestamps
    end
  end
end
