namespace :users do
  desc "guestユーザーを削除するタスク"
  task guests_delete: :environment do
    User.where(is_guest: true).delete_all
  end
end
