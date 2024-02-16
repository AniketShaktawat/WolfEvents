class UsersController < ApplicationController
  before_action :require_admin, only: [:destroy]
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    if current_user.nil?
      redirect_to login_path, notice: "Please Login First."
    elsif current_user.name !='admin'
      redirect_to root_path, notice: "Only Admin can Access All users."
    end
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    if current_user.nil?
      redirect_to login_path, notice: "Please Login First."
    elsif current_user.name!='admin' && current_user.id != params[:id].to_i
      redirect_to my_profile_path, notice: "You Cannot Access Other Profiles."
    end
  end

  # GET /users/new
  def new
    if current_user.nil?
      redirect_to login_path, notice: "Please Login First."
    elsif current_user.name!='admin'
      redirect_to root_path, notice: "Only Admin can create new users."
    end
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if current_user.nil?
      redirect_to login_path, notice: "Please Login First."
    elsif current_user.name!='admin' && current_user.id != params[:id].to_i
      redirect_to root_path, notice: "You Cannot Edit Other Profiles."
    end
  end
  
  def require_admin
    unless current_user && current_user.admin?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end
  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html do
          if current_user && current_user.name == "admin"
            redirect_to users_path, notice: "User was successfully created."
          else
            redirect_to login_path, notice: "Please log in."
          end
        end
        # format.html { redirect_to users_path, notice: "User was successfully created." }
        # format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user = User.find(params[:id])
  
    if @user == current_user
      flash[:error] = "Admin cannot delete themselves."
      redirect_to users_path
    elsif current_user.admin?
      @user.destroy
      flash[:success] = "User deleted successfully."
      redirect_to users_path
    else
      flash[:error] = "You are not authorized to delete this user."
      redirect_to users_path
    
    #@user.destroy

    #respond_to do |format|
      #format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      #format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :name, :phone_number, :address, :credit_card)
    end
end
