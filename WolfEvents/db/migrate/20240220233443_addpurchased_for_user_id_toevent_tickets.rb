class AddpurchasedForUserIdToeventTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :event_tickets, :purchased_for_user_id, :string
  end
end
