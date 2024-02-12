class User < ApplicationRecord

  has_secure_password

  validates :email, :name, :phone_number, :credit_card, presence: true, on: :create
  validates :email, uniqueness: true, allow_blank: true

end
