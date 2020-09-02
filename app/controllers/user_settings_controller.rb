class UserSettingsController < ApplicationController
  def create
    setting_id = params[:setting_id]
    @setting_classification = SettingClassification.find_by(
      id: params[:setting_classification_id]
    )
    if setting_id
      current_user.user_settings.
        find_or_initialize_by(setting_id: @setting_classification.setting_ids).
        update(setting_id: setting_id)
    else
      current_user.settings.destroy @setting_classification.settings
    end
    render
  end
end
