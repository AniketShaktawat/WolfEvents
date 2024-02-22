class User < ApplicationRecord

  has_secure_password

  has_many :reviews, dependent: :destroy
  has_many :event_tickets, dependent: :destroy
  has_many :events

  validates :email, :name, :phone_number, :credit_card, presence: true, on: :create
  validates :email, uniqueness: true, on: :create
  validates :password_digest, presence: true, on: :create
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "Invalid email format" }, on: :create
  validates :phone_number, format: { with: /\A\d{10}\z/, message: "Phone number must be 10 digits" }, on: :create
  validates :credit_card, format: { with: /\A\d{16}\z/, message: "Credit card must be 16 digits" }, on: :create

  def admin?
    is_admin
  end

end
