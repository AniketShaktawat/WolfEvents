json.extract! event_ticket, :id, :confirmationNumber, :created_at, :updated_at
json.url event_ticket_url(event_ticket, format: :json)
