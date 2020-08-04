class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.belongs_to :composer
      t.belongs_to :composition
      t.string :title, null: false
      t.index [:composer_id, :composition_id, :title], unique: true
      t.timestamps
    end
  end
end
