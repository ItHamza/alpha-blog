class SessionsController < ApplicationController

  def new
    if session[:user_id]
      flash[:notice] = "Already Logged in"
      redirect_to user_path(session[:user_id])
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully"
      redirect_to user
    else
      flash.now[:alert] = "Something wrong with login details"
      render 'new'
    end
  end

  def destroy
    if session[:user_id]
      session[:user_id] = nil
      flash[:notice] = "Logged out"
      redirect_to root_path
    else
      flash.now[:alert] = "Not logged in"
      render 'new'
    end
  end

end