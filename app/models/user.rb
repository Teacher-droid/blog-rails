class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  has_many :articles, class_name: "articles", foreign_key: "reference_id"
  has_many :comments
end
