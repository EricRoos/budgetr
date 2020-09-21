class AddNoteToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :note, :text
  end
end
