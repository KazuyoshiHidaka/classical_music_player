class AddGuestColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.boolean :is_guest, null: false, default: false
    end
  end
end
