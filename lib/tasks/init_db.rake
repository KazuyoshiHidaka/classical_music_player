namespace :init_db do
  desc "Initialize databases if databases aren't exist"
  task setup: :environment do
    raise 'Not allowed to run on production' if Rails.env.production?
    create_db unless databases_exists?
    setup_db
  end

  def create_db
    system 'bundle exec rails db:create'
  end

  def setup_db
    system 'bundle exec rails db:schema:load'
    system 'bundle exec rails db:seed'
  end

  def databases_exists?
    ActiveRecord::Base.connection
    true
  rescue ActiveRecord::NoDatabaseError
    false
  end
end
