class User < ApplicationRecord

  has_secure_password

  has_many :reviews, dependent: :destroy
  has_many :event_tickets, dependent: :destroy

  # validates :email, :name, :phone_number, :credit_card, presence: true, on: :create
  validates :email, uniqueness: true, allow_blank: true

end
