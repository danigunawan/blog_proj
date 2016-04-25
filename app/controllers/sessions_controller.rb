class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email params[:email]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Logged in"
    else
      redirect_to new_session_path, notice: "Please Sign In!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged Out!"
  end

  private

    def redirect_if_loggedin
      redirect_to root_path, notice: "Already logged in" if user_signed_in?
    end
end
