class ProfilesController < ApplicationController
    def edit
      @user = User.find(current_user.id)
    end
    def update
        @user = current_user
        if @user.update(user_params)
          redirect_to my_profile_path, notice: "Profile updated successfully"
        else
          render :edit
        end
    end
    

    private
    def require_login
        unless session[:user_id]
          flash[:alert] = "You must be logged in to access this page"
          redirect_to login_path
        end
    end
    def user_params
        params.require(:user).permit(:name, :phone_number, :address, :credit_card)
    end

end
  