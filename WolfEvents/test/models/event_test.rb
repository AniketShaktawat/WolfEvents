require "test_helper"

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end


# # spec/models/event_spec.rb
# require 'rails_helper'
#
# RSpec.describe Event, type: :model do
#   # Valid factory or attributes for a valid event
#   let(:valid_attributes) do
#     {
#       name: 'Event Name',
#       category: 'Concert',
#       date: Date.tomorrow,
#       startTime: Time.current,
#       endTime: Time.current + 2.hours,
#       ticketPrice: 50.0,
#       seatsLeft: 100,
#       room_id: create(:room).id # Assuming you have a rooms factory
#     }
#   end
#
#   describe 'validations' do
#     it 'is valid with valid attributes' do
#       event = Event.new(valid_attributes)
#       expect(event).to be_valid
#     end
#
#     it 'is not valid without a name' do
#       event = Event.new(valid_attributes.merge(name: nil))
#       expect(event).to_not be_valid
#     end
#
#     # Add more tests for other attributes...
#
#     it 'is not valid if end time is before start time' do
#       event = Event.new(valid_attributes.merge(startTime: Time.current, endTime: Time.current - 1.hour))
#       expect(event).to_not be_valid
#       expect(event.errors[:endTime]).to include('must be after start time')
#     end
#
#     it 'is not valid if date is in the past' do
#       event = Event.new(valid_attributes.merge(date: Date.yesterday))
#       expect(event).to_not be_valid
#       expect(event.errors[:date]).to include("can't be in the past")
#     end
#   end
# end
