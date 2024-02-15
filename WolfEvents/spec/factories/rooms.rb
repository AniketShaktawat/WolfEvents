# spec/factories/rooms.rb
FactoryBot.define do
  factory :room do
    location { "Conference Room A" }
    capacity { 50 }
  end
end
