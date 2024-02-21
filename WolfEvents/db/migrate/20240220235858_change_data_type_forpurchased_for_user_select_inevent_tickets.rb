class ChangeDataTypeForpurchasedForUserSelectIneventTickets < ActiveRecord::Migration[6.1]
  def change
    change_column :event_tickets, :purchased_for_user_id, :integer
  end
end
