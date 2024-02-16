class RemoveEventIdFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :event_id, :integer
  end
end
