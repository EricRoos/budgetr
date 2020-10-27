# frozen_string_literal: true

class CreateItemGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :item_groups do |t|
      t.references :project, null: false, foreign_key: true
      t.string :name
      t.integer :budget

      t.timestamps
    end
  end
end
