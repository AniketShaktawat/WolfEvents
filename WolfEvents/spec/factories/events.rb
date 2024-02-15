FactoryBot.define do
  factory :event do
    name { "Test Event" }
    category { "Concert" }
    date { Date.tomorrow }
    startTime { Time.current }
    endTime { Time.current + 2.hours }
    ticketPrice { 20.0 }
    seatsLeft { 100 }
    room { create(:room) } # Ensure you have a room factory as well
  end
end
