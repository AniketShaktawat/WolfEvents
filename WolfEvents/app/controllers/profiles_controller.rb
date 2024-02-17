class ProfilesController < ApplicationController
    def edit
      @user = User.find(current_user.id)
      if current_user.nil?
        redirect_to login_path, notice: "Please Login First."
      # elsif current_user.id != params[:id].to_i
      #   redirect_to root_path, notice: "You Cannot Edit Other Profiles."
      end
    end
    def update
        @user = current_user
        if @user.update(user_params)
          redirect_to root_path, notice: "Profile updated successfully"
        else
          render :edit
        end
    end

    def destroy
      puts "OODD"
      @user.destroy
      if(current_user.name != 'admin' && @user.name != 'admin')
        puts "OODD111"
        reset_session
      end

      puts "OODD222222"

      respond_to do |format|
        format.html { redirect_to users_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      end
        # user = current_user # Or however you get the user to be deleted
        # user.destroy
        # reset_session if user.name != 'admin'
        # redirect_to users_url, notice: "User was successfully destroyed."
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
  