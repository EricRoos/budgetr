class AddDefaultQuantityToItem < ActiveRecord::Migration[6.0]
  def up
    change_column_default :items, :quantity, 1
  end

  def down
    change_column_default :items, :quantity, nil
  end
end
