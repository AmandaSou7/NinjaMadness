class SessionsController < ApplicationController
  def new
    flash.now[:error] = nil
  end

  def create
    user = User.authenticate(params[:session][:email_address], params[:session][:password])

    if (user.nil?)
      flash.now[:error] = "Invalid email/password combination."
      render :new
    else
      # redirect_to "/users/#{user.id}"
      redirect_to "http://localhost:8000"
    end
  end

  def destroy
  	# sign_out
  	redirect_to signin_path
  end
end
