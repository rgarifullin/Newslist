class ChangeReadedColumnDefault < ActiveRecord::Migration
  def up
    change_column_default :newsusers, :read, false
  end

  def down
    change_column_default :newsusers, :read, nil
  end
end
