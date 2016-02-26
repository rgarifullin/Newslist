class ChangeDatatypeForUserRoles < ActiveRecord::Migration
  change_column :users, :role, :integer
end
