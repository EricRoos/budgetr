class AddDefaultToPurchasedForItems < ActiveRecord::Migration[6.0]
  def up
    change_column_default :items, :purchased, false
  end

  def down
    change_column_default :items, :purchased, nil
  end
end
