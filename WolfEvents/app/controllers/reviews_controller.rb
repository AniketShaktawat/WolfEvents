class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  def index
    if current_user==nil
      redirect_to login_path, notice: "Please Login First."
    end
    @reviews = Review.all
    @events = Event.all
    @users = User.all
    # @event = Event.find(params[:event_id])
  end

  # GET /reviews/1 or /reviews/1.json
  def show
    if current_user==nil
      redirect_to login_path, notice: "Please Login First."
    end
  end

  # GET /reviews/new
  def new
    @event = Event.find(params[:event_id])
    if current_user.nil?
      redirect_to login_path, notice: "Please Login First."
    end
    # if !current_user.name=='admin'
    #   redirect_to root_path, notice: "Add reviews in My bookings Section"
    # end

    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
    @event = @review.event
    if current_user.nil?
      redirect_to login_path, notice: "Please Login First."
    elsif current_user.name!='admin' && current_user.id !=@review.user_id
      redirect_to root_path, notice: "You Cannot Edit Other reviews."
    end
    # @review = Review.find(params[:id])
    # @event = @review.event
  end

  # POST /reviews or /reviews.json
  def create
    puts("inside review controller")
    @review = Review.new(review_params)
    puts("params are these #{review_params}")
    @review.user = current_user
    @event = Event.find(@review.event_id) # Retrieve the event using the event ID
    @review.event = @event


    respond_to do |format|
      if @review.save
        event = Event.find(@review.event_id)
        if current_user.name=='admin'
          format.html { redirect_to reviews_path(@review, eventName: event.name), notice: "Review was successfully created." }
        else
        format.html { redirect_to my_reviews_path(@review, eventName: event.name), notice: "Review was successfully created." }
        end
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update

    @events = Event.all
    respond_to do |format|
      if @review.update(review_params)
        if current_user.name=='admin'
          format.html { redirect_to reviews_path(@review, eventName: @events), notice: "Review was successfully updated." }
        else
          format.html { redirect_to my_reviews_path(@review, eventName: @events), notice: "Review was successfully updated." }
        end
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end



  def my_reviews
    puts("inside review controller")
    # @review = Review.new(review_params)
    # puts("params are these #{review_params}")
    # @review.user = current_user
    # @event = Event.find(@review.event_id) # Retrieve the event using the event ID
    # @review.event = @event

    @reviews = Review.all
    @events = Event.all
    @user = current_user

  end







  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy

    respond_to do |format|
      if current_user.name=='admin'
        format.html { redirect_to reviews_path, notice: "Review was successfully destroyed." }
      else
        format.html { redirect_to my_reviews_path, notice: "Review was successfully destroyed." }
      end

      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:rating, :feedback, :event_id)
    end
end
