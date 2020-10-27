# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :item_group, null: false, foreign_key: true
      t.string :name
      t.integer :quantity
      t.integer :purchase_price_cents

      t.timestamps
    end
  end
end
