class EventTicket < ApplicationRecord

  # attr_accessor :purchase_type

  belongs_to :user
  belongs_to :event
  belongs_to :room

  validates :confirmationNumber, presence: true, numericality: { greater_than_or_equal_to: 1 }
  # validates :number_of_tickets, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :ticket_quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }

end
