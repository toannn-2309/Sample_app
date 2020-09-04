class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      check_activated user
    else
      flash[:danger] = t "session.noti.danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def check_activated user
    if user.activated?
      log_in user
      check_remember params[:session][:remember_me], user
      redirect_back_or user
    else
      flash[:warning] = t "session.noti.warning"
      redirect_to root_url
    end
  end

  def check_remember remember_me, user
    remember_me == Settings.session.remember ? remember(user) : forget(user)
  end
end
