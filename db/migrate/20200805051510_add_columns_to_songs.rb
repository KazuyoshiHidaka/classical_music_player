class AddColumnsToSongs < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        change_table :songs do |t|
          t.remove_index [:composer_id, :composition_id, :title]
          t.remove :title
        end
      end
      dir.down do
        change_table :songs do |t|
          t.string :title, null: false
          t.index [:composer_id, :composition_id, :title], unique: true
        end
      end
    end

    change_table :songs do |t|
      t.string :opus, null: false
      t.integer :number
      t.string :key, null: false
      t.string :alt_name
      t.index [:composer_id, :opus, :number], unique: true
    end
  end
end
