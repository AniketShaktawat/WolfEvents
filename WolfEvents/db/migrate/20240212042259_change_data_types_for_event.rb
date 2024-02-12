class ChangeDataTypesForEvent < ActiveRecord::Migration[6.1]
  def change

    change_column :events, :date, :date
    change_column :events, :startTime, :time
    change_column :events, :endTime, :time
    change_column :events, :ticketPrice, :float
  end
end
