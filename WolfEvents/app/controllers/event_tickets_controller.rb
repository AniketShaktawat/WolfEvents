class EventTicketsController < ApplicationController
  before_action :set_event_ticket, only: %i[ show edit update destroy ]

  # GET /event_tickets or /event_tickets.json
  def index
   # @event_tickets = EventTicket.all
    @event_tickets = current_user.event_tickets.includes(:event)
    current_datetime = DateTime.now
    @upcoming_events = @event_tickets.select { |event_ticket| event_ticket.event.date > current_datetime.to_date || (event_ticket.event.date == current_datetime.to_date && event_ticket.event.startTime > current_datetime.strftime('%H:%M:%S')) }
    #@upcoming_events = @event_tickets.select { |event_ticket| event_ticket.event.date >= Date.today }
    @past_events = @event_tickets.select { |event_ticket| event_ticket.event.date < current_datetime.to_date || (event_ticket.event.date == current_datetime.to_date && event_ticket.event.startTime < current_datetime.strftime('%H:%M:%S')) }
    #@past_events = @event_tickets.select { |event_ticket| event_ticket.event.startTime < Time.zone.now }
    #@past_events = @event_tickets.select { |event_ticket| event_ticket.event.date < Date.today }
    
  end

  # GET /event_tickets/1 or /event_tickets/1.json
  def show
  end

  # GET /event_tickets/new
  def new
    @event_ticket = EventTicket.new
    @event_ticket.user = current_user
    # @event = Event.find_by_id()
    # @event = Event.find(@review.event_id) # Retrieve the event using the event ID
    @event = Event.find(params[:event_id])
    @confirmation_number = SecureRandom.random_number(1_000..9_999)
    #@event
    # @room = Room.find_by_id(@event.room_id)
    #puts @room
  end

  # GET /event_tickets/1/edit
  def edit
  end

  # POST /event_tickets or /event_tickets.json
  def create
    filtered_params=event_ticket_params.except(:number_of_tickets)
    @event_ticket = EventTicket.new(filtered_params)

    respond_to do |format|
      if @event_ticket.save
        @event_ticket.update(confirmationNumber: get_confirmation)
        @event = Event.find(event_ticket_params[:event_id])
        @event.update(seatsLeft: @event.seatsLeft - event_ticket_params[:number_of_tickets].to_i)
        format.html { redirect_to event_ticket_url(@event_ticket), notice: "Event ticket was successfully created." }
        format.json { render :show, status: :created, location: @event_ticket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_tickets/1 or /event_tickets/1.json
  def update
    respond_to do |format|
      if @event_ticket.update(event_ticket_params)
        format.html { redirect_to event_ticket_url(@event_ticket), notice: "Event ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @event_ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_tickets/1 or /event_tickets/1.json
  def destroy
    @event_ticket.destroy

    respond_to do |format|
      format.html { redirect_to event_tickets_url, notice: "Event ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_ticket
      @event_ticket = EventTicket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_ticket_params
      params.require(:event_ticket).permit(:confirmationNumber, :event_id, :user_id, :number_of_tickets)
    end

  def get_confirmation
    rand(300_000..888_989)
    end
end
