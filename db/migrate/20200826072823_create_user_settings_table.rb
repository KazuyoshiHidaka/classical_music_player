class CreateUserSettingsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :settings, id: false do |t|
      t.integer :id, primary_key: true
      t.string :description, null: false
      t.timestamps
      t.index :description, unique: true
    end
  end
end
