class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :category
      t.string :date
      t.string :startTime
      t.string :endTime
      t.string :ticketPrice
      t.integer :seatsLeft

      t.timestamps
    end
  end
end
