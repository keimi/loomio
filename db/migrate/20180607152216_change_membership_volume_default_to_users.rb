class ChangeMembershipVolumeDefaultToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:users, :default_membership_volume, 0)

  end
end
