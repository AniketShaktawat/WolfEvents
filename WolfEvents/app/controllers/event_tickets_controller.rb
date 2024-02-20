class EventTicketsController < ApplicationController
  before_action :set_event_ticket, only: %i[ show edit update destroy ]

  # GET /event_tickets or /event_tickets.json
  def index
    if current_user.nil?
      redirect_to login_path, notice: "Please Login First."
    # elsif current_user.name!='admin'
    #   redirect_to root_path, notice: "Only Admin can Access All the Tickets."
    end
   # @event_tickets = EventTicket.all
    @event_tickets = current_user.event_tickets.includes(:event)
    current_datetime = DateTime.now.utc

    @upcoming_events = @event_tickets.select { |event_ticket| event_ticket.event.date > current_datetime.to_date || (event_ticket.event.date == current_datetime.to_date && event_ticket.event.startTime.strftime('%H:%M') >= current_datetime.strftime('%H:%M')) }
    
    @past_events = @event_tickets.select { |event_ticket| event_ticket.event.date < current_datetime.to_date || (event_ticket.event.date == current_datetime.to_date && event_ticket.event.startTime.strftime('%H:%M') < current_datetime.strftime('%H:%M')) }
    puts current_datetime.to_date
    puts @past_events

  end

  # GET /event_tickets/1 or /event_tickets/1.json
  def show
    if current_user.nil?
      redirect_to login_path, notice: "Please Login First."
    # elsif current_user.name!='admin'
    #   redirect_to root_path, notice: "You Cannot Access Other Tickets."
    end
  end

  # GET /event_tickets/new
  def new
    if current_user.nil?
      redirect_to login_path, notice: "Please Login First."
    # elsif current_user.name!='admin'
    #   redirect_to root_path, notice: "Only Admin can create new tickets."
    end
    @event_ticket = EventTicket.new
    @event_ticket.user = current_user
    # @event = Event.find_by_id()
    # @event = Event.find(@review.event_id) # Retrieve the event using the event ID
    @event = Event.find(params[:event_id])
    puts (@event.name)
    @confirmation_number = SecureRandom.random_number(1_000..9_999)
    #@event
    # @room = Room.find_by_id(@event.room_id)
    #puts @room
  end

  # GET /event_tickets/1/edit
  def edit
    if current_user.nil?
      redirect_to login_path, notice: "Please Login First."
    elsif current_user.name!='admin'
      redirect_to root_path, notice: "You Cannot Edit Tickets."
    end
    @event_ticket= EventTicket.find(params[:id])
    @event = @event_ticket.event
  end

  # POST /event_tickets or /event_tickets.json
  def create
    # filtered_params=event_ticket_params.except(:number_of_tickets)
    # filtered_params=event_ticket_params.except(:room_id)
    # @event_ticket = EventTicket.new(filtered_params)
    @event = Event.find(event_ticket_params[:event_id].to_i)
    @event_ticket = EventTicket.new(event_ticket_params)
    @event_ticket.update(confirmationNumber: get_confirmation)
    @event_ticket.update(room_id: @event.room_id)
    respond_to do |format|
      if @event_ticket.save
        @event = Event.find(event_ticket_params[:event_id].to_i)
        # @event.update(seatsLeft: @event.seatsLeft - event_ticket_params[:number_of_tickets].to_i)
        @event.update(seatsLeft: @event.seatsLeft - event_ticket_params[:ticket_quantity].to_i)
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
      @event_ticket_old = @event_ticket.ticket_quantity
      puts @event_ticket_old
      puts event_ticket_params[:ticket_quantity].to_i
      if @event_ticket.update(event_ticket_params)
        @event = Event.find(event_ticket_params[:event_id])
        temp =  event_ticket_params[:ticket_quantity].to_i - @event_ticket_old
        puts "Ballu"
        puts temp
        # @event.update(seatsLeft: @event.seatsLeft - event_ticket_params[:number_of_tickets].to_i)
          @event.update(seatsLeft: @event.seatsLeft - temp)
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

    @event = Event.find(@event_ticket.event_id)
    @event.update(seatsLeft: @event.seatsLeft + @event_ticket.ticket_quantity)
    @event_ticket.destroy

    respond_to do |format|
      format.html { redirect_to event_tickets_url, notice: "Event ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def all_bookings
    @event_tickets = EventTicket.all
    # @user = User.find(@event_ticket.user_id)
    puts "testing"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_ticket
      @event_ticket = EventTicket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_ticket_params
      # params.require(:event_ticket).permit(:confirmationNumber, :event_id, :user_id, :number_of_tickets)
      params.require(:event_ticket).permit(:confirmationNumber, :event_id, :user_id, :ticket_quantity, :room_id)
    end

  def get_confirmation
    rand(300_000..888_989)
    end
end
