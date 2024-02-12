json.extract! event, :id, :name, :category, :date, :startTime, :endTime, :ticketPrice, :seatsLeft, :created_at, :updated_at
json.url event_url(event, format: :json)
