class CreateNewsusers < ActiveRecord::Migration
  def change
    create_table :newsusers do |t|
      t.belongs_to :news, index: true
      t.belongs_to :user, index: true
      t.boolean :read
      t.timestamps null: false
    end
  end
end
