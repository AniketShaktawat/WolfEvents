class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    if current_user==nil
      redirect_to login_path, notice: "Please Login First."
    end

    @events = Event.all
    @rooms = Room.all
  end

  # GET /events/1 or /events/1.json
  def show
    if current_user==nil
      redirect_to login_path, notice: "Please Login First."
    end
  end

  # GET /events/new
  def new
    if current_user.nil?
      redirect_to login_path, notice: "Please Login First."
    end
    if current_user.name!='admin'
      redirect_to root_path, notice: "Only Admin can create new Events."
    end
    @event = Event.new
    @rooms = Room.all
    @event.startTime = Time.current.strftime("%H:%M")
    @event.endTime = Time.current.strftime("%H:%M")
  end

  # GET /events/1/edit
  def edit
    if current_user.nil?
      redirect_to login_path, notice: "Please Login First."
    elsif current_user.name!='admin'
      redirect_to root_path, notice: "You Cannot Edit Events."
    end
    @rooms = Room.all
    @event = Event.find(params[:id])
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        puts "if"
        format.html { redirect_to events_path, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        puts "else"
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to events_path, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_path, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # app/controllers/events_controller.rb

  # def filter
  #   # Assuming you have an Event model
  #   @events = Event.all
  #
  #   @events = @events.where("category = ?", params[:category]) if params[:category].present?
  #   @events = @events.where("date = ?", params[:date]) if params[:date].present?
  #   @events = @events.where("price >= ?", params[:min_price]) if params[:min_price].present?
  #   @events = @events.where("price <= ?", params[:max_price]) if params[:max_price].present?
  #   @events = @events.where("lower(name) LIKE ?", "%#{params[:event_name].downcase}%") if params[:event_name].present?
  #
  #   render json: @events
  # end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :category, :date, :startTime, :endTime, :ticketPrice, :seatsLeft, :room_id)
    end
end
