class Room < ApplicationRecord

  has_many :events, dependent: :destroy
  # has_many :event_tickets, dependent: :destroy


  # validates :location, :capacity, presence: true, on: :create

end
