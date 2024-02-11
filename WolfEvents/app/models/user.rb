class User < ApplicationRecord

  has_secure_password

  # validates :email, presence: true, uniqueness: true
  #
  # validates :email, :name, :phone_number, :credit_card, :password_digest, :address, :credit_card, presence: true
  # validates :email, :name, :phone_number, :credit_card, uniqueness: true

  validates :email, :name, :phone_number, :credit_card, presence: true, on: :create
  validates :email, :name, uniqueness: true, allow_blank: true
  # validates :email, uniqueness: { message: 'This email address is already taken.' }

  # validates :password_digest, :address, :credit_card, presence: true


  # def self.find_by_email_address(email)
  #
  #   puts "test"
  #   # code here
  #   user = User.find_by(email: email)
  #   if user
  #     puts "User with email #{user.email} found!"
  #   else
  #     puts "User with email #{email} not found."
  #   end
  #   user
  # end

end
