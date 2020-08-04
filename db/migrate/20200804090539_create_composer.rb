class CreateComposer < ActiveRecord::Migration[6.0]
  def change
    create_table :composers do |t|
      t.string :name, null: false
      t.index :name, unique: true
      t.timestamps
    end
  end
end
