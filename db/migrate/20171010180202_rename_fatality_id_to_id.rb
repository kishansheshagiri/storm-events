class RenameFatalityIdToId < ActiveRecord::Migration[5.1]
  def change
    rename_column :fatalities, :fatality_id, :id
    change_column :fatalities, :id, :integer, unsigned: true, null: false, auto_increment: true
  end
end
