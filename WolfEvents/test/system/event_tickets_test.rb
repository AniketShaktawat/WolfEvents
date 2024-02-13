require "application_system_test_case"

class EventTicketsTest < ApplicationSystemTestCase
  setup do
    @event_ticket = event_tickets(:one)
  end

  test "visiting the index" do
    visit event_tickets_url
    assert_selector "h1", text: "Event Tickets"
  end

  test "creating a Event ticket" do
    visit event_tickets_url
    click_on "New Event Ticket"

    fill_in "Confirmationnumber", with: @event_ticket.confirmationNumber
    click_on "Create Event ticket"

    assert_text "Event ticket was successfully created"
    click_on "Back"
  end

  test "updating a Event ticket" do
    visit event_tickets_url
    click_on "Edit", match: :first

    fill_in "Confirmationnumber", with: @event_ticket.confirmationNumber
    click_on "Update Event ticket"

    assert_text "Event ticket was successfully updated"
    click_on "Back"
  end

  test "destroying a Event ticket" do
    visit event_tickets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Event ticket was successfully destroyed"
  end
end
