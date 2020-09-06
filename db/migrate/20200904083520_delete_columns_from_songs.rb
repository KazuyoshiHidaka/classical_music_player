class DeleteColumnsFromSongs < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        change_table :songs do |t|
          t.remove_index %i(composer_id opus number)
          t.remove :opus
          t.remove :number
          t.remove :key
          t.remove :alt_name
        end
      end
      dir.down do
        change_table :songs do |t|
          t.string :opus, null: false
          t.integer :number
          t.string :key, null: false
          t.string :alt_name
          t.index %i(composer_id opus number), unique: true
        end
      end
    end

    change_table :songs do |t|
      t.string :title, null: false
    end
  end
end
