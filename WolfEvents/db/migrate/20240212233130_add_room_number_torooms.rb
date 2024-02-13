class AddRoomNumberTorooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :roomNumber, :integer
  end
end
