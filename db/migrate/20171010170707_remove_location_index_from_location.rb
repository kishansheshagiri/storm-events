class RemoveLocationIndexFromLocation < ActiveRecord::Migration[5.1]
  def change
    remove_column :locations, :location_index
  end
end
