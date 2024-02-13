class RemoveColumnNameFromTableName < ActiveRecord::Migration[6.1]
  def change
    remove_column :rooms, :roomNumber, :integer
  end
end
