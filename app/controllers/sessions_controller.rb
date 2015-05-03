class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])
      login(@user)
      redirect_to new_signature_request_path
    else
      render :new
    end
  end

  private

  def login(user)
    session[:user_id] = user.id
  end
end
