class Event < ApplicationRecord

  has_many :reviews, dependent: :destroy
  has_many :event_tickets, dependent: :destroy
  has_many :users
  belongs_to :room

  validates :name, :category, :date, :startTime, :endTime, :ticketPrice, :seatsLeft, presence: true, on: :create
  validates :ticketPrice, numericality: { greater_than_or_equal_to: 0 }
  validates :seatsLeft, numericality: { greater_than_or_equal_to: 0 }

  validate :seats_left_do_not_exceed_room_capacity

  private

  def seats_left_do_not_exceed_room_capacity
    return unless room && seatsLeft

    if seatsLeft > room.capacity
      errors.add(:seatsLeft, "cannot be greater than the room's capacity (#{room.capacity})")
    end
  end

  validate :start_time_before_end_time

  def available_tickets
    seatsLeft
  end

  private

  def start_time_before_end_time
    return unless startTime && endTime
    errors.add(:endTime, "must be after start time") if startTime >= endTime
  end

  validate :date_cannot_be_in_the_past

  private

  def date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if date && date < Date.today
  end

end
