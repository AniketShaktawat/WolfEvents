require 'rails_helper'

RSpec.describe Event, type: :model do
  #testing validations
  describe 'validations' do
    it 'is valid with valid attributes' do
    room = Room.create!(location: 'Test Location', capacity: 150) # Adjust attributes as necessary
    event = Event.new(name: 'Test Event', category: 'Concert', date: Date.tomorrow, startTime: Time.current, endTime: Time.current + 2.hours, ticketPrice: 20.0, seatsLeft: 100, room: room)
    expect(event).to be_valid
  end

    it 'is not valid without a name' do
      event = Event.new(name: nil)
      expect(event).to_not be_valid
    end

    # Add more tests for other attributes...
  end

  #testing cutom validation methods
  describe 'custom validations' do
    it 'is not valid if end time is before start time' do
      event = Event.new(startTime: Time.now, endTime: Time.now - 1.hour)
      event.valid?
      expect(event.errors[:endTime]).to include('must be after start time')
    end

    it 'is not valid if date is in the past' do
      event = Event.new(date: Date.yesterday)
      event.valid?
      expect(event.errors[:date]).to include("can't be in the past")
    end
  end

  #testing instance methods
  describe 'instance methods' do
    describe '#available_tickets' do
      it 'returns the correct number of available tickets' do
        event = Event.new(seatsLeft: 100)
        # Assuming some tickets were sold, adjust the seatsLeft accordingly
        event.seatsLeft -= 10
        expect(event.available_tickets).to eq(90)
      end
    end
  end


end
