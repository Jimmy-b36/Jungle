class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password is entered correctly.
    if user && user.authenticate(params[:password])
      # Save the use r inside the browser cookie. This is how we keep the user 
      # logged in as they navigate around the site
      session[:user_id] = user.id
      redirect_to '/'
      else
        # If the login doesn't work redirect to the login page
      redirect_to '/login'
      end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
