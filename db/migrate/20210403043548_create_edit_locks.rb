class CreateEditLocks < ActiveRecord::Migration[6.0]
  def change
    create_table :edit_locks do |t|
      t.references :lockable, null: false, polymorphic: true
      t.boolean :locked

      t.timestamps
    end
  end
end
