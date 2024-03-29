class EventTicketsController < ApplicationController
  before_action :set_event_ticket, only: %i[ show edit update destroy ]

  # GET /event_tickets or /event_tickets.json
  def index
    if current_user.nil?
      redirect_to login_path, notice: "Please Login First."
      return
    end
    @event_tickets = EventTicket.includes(:event).where(user_id: current_user.id).or(EventTicket.includes(:event).where(purchased_for_user_id: current_user.id))
    current_datetime = DateTime.now.utc

    @upcoming_events = @event_tickets.select { |event_ticket| event_ticket.event.date > current_datetime.to_date || (event_ticket.event.date == current_datetime.to_date && event_ticket.event.startTime.strftime('%H:%M') >= current_datetime.strftime('%H:%M')) }
    
    @past_events = @event_tickets.select { |event_ticket| event_ticket.event.date < current_datetime.to_date || (event_ticket.event.date == current_datetime.to_date && event_ticket.event.startTime.strftime('%H:%M') < current_datetime.strftime('%H:%M')) }

  end

  # GET /event_tickets/1 or /event_tickets/1.json
  def show
    @event_ticket = EventTicket.find(params[:id])
    if current_user.nil?
      redirect_to login_path, notice: "Please Login First."
    elsif current_user.name!='admin' && current_user.id != @event_ticket.user_id
      redirect_to root_path, notice: "You Cannot View This Ticket."
    end
  end

  # GET /event_tickets/new
  def new
    @event = Event.find(params[:event_id])
    if current_user.nil?
      redirect_to login_path, notice: "Please Login First."
    elsif @event.date < Date.today || (@event.date == Date.today && @event.startTime.strftime('%H:%M') < DateTime.now.utc.strftime('%H:%M'))
        redirect_to root_url, notice: "You cannot buy ticket for past events."
    end
    @event_ticket = EventTicket.new
    @event_ticket.user = current_user
    @confirmation_number = SecureRandom.random_number(1_000..9_999)
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


    @event = Event.find(event_ticket_params[:event_id].to_i)
    filtered_parameters = event_ticket_params.except(:purchase_type)
    @event_ticket = EventTicket.new(filtered_parameters)
    puts event_ticket_params[:event_id].to_i

    if(@event_ticket.purchased_for_user_id.nil?)
      @event_ticket.update(purchased_for_user_id: current_user.id)
    end
    @event_ticket.update(confirmationNumber: get_confirmation)
    @event_ticket.update(room_id: @event.room_id)

    respond_to do |format|
      if @event_ticket.save
        @event = Event.find(event_ticket_params[:event_id].to_i)
        @event.update(seatsLeft: @event.seatsLeft - event_ticket_params[:ticket_quantity].to_i)
        puts @event.seatsLeft
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
    filtered_parameters = event_ticket_params.except(:purchase_type)
    respond_to do |format|
      @event_ticket_old = @event_ticket.ticket_quantity
      puts @event_ticket_old
      puts event_ticket_params[:ticket_quantity].to_i
      if @event_ticket.update(filtered_parameters)
        @event = Event.find(event_ticket_params[:event_id])
        temp =  event_ticket_params[:ticket_quantity].to_i - @event_ticket_old
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
      if(current_user.is_admin?)
        format.html { redirect_to all_bookings_url, notice: "Event ticket was successfully destroyed." }
      else
        format.html { redirect_to event_tickets_url, notice: "Event ticket was successfully destroyed." }
      end

      format.json { head :no_content }
    end
  end

  def all_bookings
    if current_user.name!='admin'
      redirect_to root_path, notice: "You Cannot See Other bookings."
    end
    @event_tickets = EventTicket.all
  end

  private
    def set_event_ticket
      @event_ticket = EventTicket.find(params[:id])
    end

    def event_ticket_params
      params.require(:event_ticket).permit(:confirmationNumber, :event_id, :user_id, :ticket_quantity, :room_id, :purchased_for_user_id, :purchase_type)
    end

  def get_confirmation
    rand(300_000..888_989)
    end
end
