class AddKeyToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :event, null: false, foreign_key: true
  end
end
