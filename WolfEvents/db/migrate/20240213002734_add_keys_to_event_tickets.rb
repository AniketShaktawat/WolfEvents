class AddKeysToEventTickets < ActiveRecord::Migration[6.1]
  def change
    add_reference :event_tickets, :user, null: false, foreign_key: true
    add_reference :event_tickets, :event, null: false, foreign_key: true
  end
end
