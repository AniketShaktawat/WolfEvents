class AddTicketQuantityToEventTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :event_tickets, :ticket_quantity, :integer
  end
end
