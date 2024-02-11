# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.create!(
  email: 'admin@gmail.com',
  name: 'admin',
  phone_number: '1234567890',
  address: 'Admin_Address',
  credit_card: 'Admin_Credit_Card_Number',
  password_digest: '$2a$12$gXKl/SJwgCj76s38Yv7ErO3hIqZ5.LFE2ES./kRPCFb5emvCaqVDe',
  # password_digest_confirmation: 'admin_password',
  is_admin: true
)
puts 'Admin user created!'
