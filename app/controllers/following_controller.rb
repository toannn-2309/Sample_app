class FollowingController < ApplicationController
  before_action :load_user

  def index
    @title = t "follow.following"
    @users = @user.following.page(params[:page]).per Settings.per_page
    render "users/show_follow"
  end
end
