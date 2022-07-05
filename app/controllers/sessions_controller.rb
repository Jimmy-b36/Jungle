class SessionsController < ApplicationController
  def new
  end

  def create
    if user =
         User.authenticate_with_credentials(params[:email], params[:password])
      # Save the use r inside the browser cookie. This is how we keep the user
      # logged in as they navigate around the site
      session[:user_id] = user.id
      redirect_to "/"
    else
      # If the login doesn't work redirect to the login page
      redirect_to "/login"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/login"
  end
end
