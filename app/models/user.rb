class User < ApplicationRecord
  has_many :user_settings, dependent: :destroy
  has_many :settings, through: :user_settings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    User.create(
      email: "guest.#{Time.current.strftime "%Y%m%d%H%M%S"}@email.com",
      password: SecureRandom.urlsafe_base64,
      is_guest: true
    )
  end
end
