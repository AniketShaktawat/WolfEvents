FactoryBot.define do
  factory :user do
    email { "test@example.com" }
    name { "Test User" }
    phone_number { "1234567890" } # 10 digits as per your validation
    credit_card { "1234567890123456" } # 16 digits as per your validation
    password { "password" } # Assuming you have a password field for has_secure_password
    password_confirmation { "password" }
    
  end
end
