class RemoveNotNullConstraintFromUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :event_id, true
  end
end
