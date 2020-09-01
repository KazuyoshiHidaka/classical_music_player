class ChangeSettingToBelongToSettingClassification < ActiveRecord::Migration[6.0]
  def change
    change_table :settings do |t|
      t.belongs_to :setting_classification
    end
  end
end
