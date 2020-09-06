class CreateUsersSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :user_settings do |t|
      t.belongs_to :setting
      t.belongs_to :setting_classification
      t.belongs_to :user
      t.timestamps
      t.index %i(setting_classification_id user_id), unique: true
    end
  end
end
