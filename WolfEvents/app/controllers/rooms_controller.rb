class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]

  # GET /rooms or /rooms.json
  def index
    if current_user.nil?
      redirect_to login_path, notice: "Please Login First."
    elsif current_user.name!='admin'
      redirect_to root_path, notice: "Only Admin can Access All the Rooms."
    end
    @rooms = Room.all
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    if current_user.nil?
      redirect_to login_path, notice: "Please Login First."
    elsif current_user.name!='admin'
      redirect_to my_profile_path, notice: "You Cannot Access Rooms."
    end
  end

  # GET /rooms/new
  def new
    if current_user.nil?
      redirect_to login_path, notice: "Please Login First."
    elsif current_user.name!='admin'
      redirect_to my_profile_path, notice: "You Cannot Create Rooms."
    end
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
    if current_user.nil?
      redirect_to login_path, notice: "Please Login First."
    elsif current_user.name!='admin'
      redirect_to root_path, notice: "You Cannot Edit Rooms."
    end
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to rooms_path, notice: "Room was successfully created." }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to rooms_path, notice: "Room was successfully updated." }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def available
    date = Date.parse(params[:date])
    startTime = Time.parse(params[:start_time]).strftime('%H:%M')
    endTime = Time.parse(params[:end_time]).strftime('%H:%M')

    @rooms = Room.all
    @available_rooms = Room.all
    @rooms.each do |room|
      @events = room.events
      @events.each do |event|
        event_startTime = event.startTime.strftime('%H:%M')
        event_endTime = event.endTime.strftime('%H:%M')
        if date == event.date && !(startTime >= event_endTime || endTime <= event_startTime)
          puts "under if"
          @available_rooms = @available_rooms.where.not(id: event.room_id)
        end

      end
      puts @events
    end
    render json: { rooms: @available_rooms.as_json(only: [:id, :location]) }
  end




  private
    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:location, :capacity)
    end
end
