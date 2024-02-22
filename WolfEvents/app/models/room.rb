class Room < ApplicationRecord

  has_many :events, dependent: :destroy
  has_many :event_tickets, dependent: :destroy
  has_many :event_tickets, dependent: :destroy


  validates :location, :capacity, presence: true, uniqueness:true
  validates :capacity, presence: true, numericality: { greater_than_or_equal_to: 1 }

end
