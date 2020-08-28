class CreateUsersSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings_users, primary_key: %i(setting_id user_id) do |t|
      t.belongs_to :setting
      t.belongs_to :user
      t.timestamps
    end
  end
end
