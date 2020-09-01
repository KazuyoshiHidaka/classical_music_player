class User < ApplicationRecord
  has_many :user_settings, dependent: :destroy
  has_many :settings, through: :user_settings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
