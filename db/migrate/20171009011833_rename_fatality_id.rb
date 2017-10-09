class RenameFatalityId < ActiveRecord::Migration[5.1]
  def change
    rename_column :fatalities, :id, :fatality_id
  end
end
