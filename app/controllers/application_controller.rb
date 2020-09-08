class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:cached_all_songs_list]
  add_flash_types :success, :info, :warning, :danger
end
