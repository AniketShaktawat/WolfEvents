class Review < ApplicationRecord
  # Associations
  belongs_to :attendee
  belongs_to :event

end
