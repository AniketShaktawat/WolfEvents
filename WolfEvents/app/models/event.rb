class Event < ApplicationRecord

  has_many :reviews, dependent: :destroy
  has_many :event_tickets, dependent: :destroy
  belongs_to :room

  validates :name, :category, :date, :startTime, :endTime, :ticketPrice, :seatsLeft, presence: true, on: :create

  validate :start_time_before_end_time

  def available_tickets
    #  seatsLeft represents the available tickets
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
