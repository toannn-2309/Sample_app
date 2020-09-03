class UsersController < ApplicationController
  before_action :get_user, only: :show

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "pages.home.welcome"
      redirect_to @user
    else
      flash.now[:danger] = t "user.noti.danger"
      render :new
    end
  end

  private

  def get_user
    @user = User.find_by params[:id]
    return if @user

    flash[:danger] = t "user.noti.show"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit User::USERS_PARAMS
  end
end
