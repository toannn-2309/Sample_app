class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy
  before_action :current_post, only: :create

  def create
    if @micropost.save
      flash[:success] = t "post.noti.post_created"
      redirect_to root_url
    else
      @feed_items = current_user.feed.page(params[:page]).per Settings.per_page
      flash.now[:danger] = t "post.noti.create_fail"
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "post.noti.post_deleted"
    else
      flash.now[:danger] = t "post.noti.delete_fail"
    end
    redirect_to request.referer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit Micropost::MICROPOST_PARAMS
  end

  def current_post
    @micropost = current_user.microposts.build micropost_params
    @micropost.image.attach micropost_params[:image]
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url unless @micropost
  end
end
