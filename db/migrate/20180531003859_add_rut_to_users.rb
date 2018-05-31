class AddRutToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :rut, :string, :null => '', :default => ''
  end
end
