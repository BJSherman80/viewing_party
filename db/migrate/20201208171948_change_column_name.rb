class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :guests, :guest_id, :friend_id
  end
end
