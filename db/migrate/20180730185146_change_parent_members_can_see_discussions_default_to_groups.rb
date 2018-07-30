class ChangeParentMembersCanSeeDiscussionsDefaultToGroups < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:groups, :parent_members_can_see_discussions, true)

  end
end
