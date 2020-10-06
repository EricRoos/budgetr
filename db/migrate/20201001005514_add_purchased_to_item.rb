class AddPurchasedToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :purchased, :boolean
  end
end
