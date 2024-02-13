class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]

  # GET /rooms or /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1 or /rooms/1.json
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
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

  # def available
  #   date = params[:date]
  #   start_time = params[:startTime]
  #   end_time = params[:endTime]
  #
  #   puts(date)
  #   puts(start_time)
  #   puts(end_time)
  #
  #   @available_rooms = Room.left_joins(:events)
  #                          .where.not(events: {id: nil, date: date, start_time: start_time..end_time})
  #                          .or(Room.left_joins(:events).where(events: {id: nil}))
  #                          .distinct
  #
  #   puts @available_rooms
  #
  #   render json: {rooms: @available_rooms.select(:id, :location).as_json}
  # end
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
        if (date == event.date && !(startTime >= event_endTime || endTime <= event_startTime))
          puts "under if"
          @available_rooms = @available_rooms.where.not(id: event.room_id)
        end

      end
      puts @events
    end
    render json: { rooms: @available_rooms.as_json(only: [:id, :location]) }
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:location, :capacity)
    end
end