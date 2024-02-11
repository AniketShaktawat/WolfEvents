class SessionsController < ApplicationController
  def new
  end
  puts "test1"
  def create
    puts"test2"
    user = User.find_by_email(params[:email])
    puts user.email if user.present?
    puts "test3"
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end


end
