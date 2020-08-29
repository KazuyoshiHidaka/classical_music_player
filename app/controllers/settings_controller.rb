class SettingsController < ApplicationController
  before_action :set_setting, only: %i(create_setting_user destroy_setting_user)

  def create_setting_user
    users = @setting.users
    if users.find_by(id: current_user.id)
      head :no_content
    else
      users << current_user
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  def destroy_setting_user
    users = @setting.users
    if users.find_by(id: current_user.id)
      users.destroy current_user
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      head :no_content
    end
  end

  private

  def set_setting
    @setting = Setting.find_by(id: params[:setting_id])
  end
end
