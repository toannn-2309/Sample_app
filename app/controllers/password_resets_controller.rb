class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "pw_reset.noti.send_mail"
      redirect_to root_url
    else
      flash.now[:danger] = t "pw_reset.noti.mail_fail"
      render :new
    end
  end

  def edit; end

  def update
    if user_params[:password].blank?
      @user.errors.add :password, t("pw_reset.noti.pw_empty")
      render :edit
    elsif @user.update user_params
      log_in @user
      flash[:success] = t "pw_reset.noti.pw_pass"
      redirect_to @user
    else
      flash[:danger] = t "pw_reset.noti.pw_fail"
      render :edit
    end
  end

  private

  def get_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t "user.noti.show"
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def valid_user
    return if @user&.activated? && @user&.authenticated?(:reset, params[:id])

    flash[:danger] = t "pw_reset.noti.invalid_user"
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "pw_reset.noti.pw_expired"
    redirect_to new_password_reset_url
  end
end
