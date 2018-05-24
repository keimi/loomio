class AddIsRdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_rd, :boolean, :null => false, :default => false
  end
end
