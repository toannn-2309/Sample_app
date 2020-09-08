class UsersController < ApplicationController
  before_action :get_user, except: %i(index new create)
  before_action :logged_in_user, except: %i(new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.activated.page(params[:page]).per Settings.user.per_page
  end

  def new
    @user = User.new
  end

  def show; end

  def edit; end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:success] = t "pages.home.check_mail"
      redirect_to root_url
    else
      flash.now[:danger] = t "user.noti.danger"
      render :new
    end
  end

  def update
    if @user.update user_params
      flash[:success] = t "user.noti.update_true"
      redirect_to @user
    else
      flash[:danger] = t "user.noti.update_fail"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user.noti.destroy_true"
    else
      flash[:danger] = t "user.noti.destroy_fail"
    end
    redirect_to users_url
  end

  private

  def get_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "user.noti.show"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit User::USERS_PARAMS
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "user.noti.log_in"
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.is_admin?
  end
end
