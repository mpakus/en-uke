class LinksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def my
    @user_links = current_user.links.where('state != 10').ordered.all if user_signed_in?
  end

  def index
    unless params[:user_token].blank?
      @user  = User.where(token: params[:user_token]).first
      @links = Link.where(user: @user).ordered.limit(20).all if @user
    end
  end

  def exist
    unless params[:user_token].blank?
      @user = User.where(token: params[:user_token]).first
      @link = Link.where(user: @user, url: params[:url]).first if @user
    end
  end

  def keep
    unless params[:user_token].blank?
      @user = User.where(token: params[:user_token]).first
      if @user
        @link = Link.where(user: @user, url: params[:url]).first
        if @link.keeped?
          @link.unkeep
        else
          @link.keep
        end
      end
    end
    respond_to do |format|
      format.json { render 'exist', type: :jbuilder }
    end
  end

  def create
    unless params[:user_token].blank? || params[:url].blank?
      @user = User.where(token: params[:user_token]).first
      @link = Link.create(url: params[:url], title: params[:title], user: @user) if @user
    end
    respond_to do |format|
      format.json { render 'create', type: :jbuilder }
    end
  end

end
