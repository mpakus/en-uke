class LinksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def my
    @user_links = current_user.links.living.ordered.all if user_signed_in?
  end

  def index
    unless params[:user_token].blank?
      @user  = User.where(token: params[:user_token]).first
      @links = Link.where(user: @user).living.ordered.limit(20).all if @user
    end
  end

  def exist
    unless params[:user_token].blank?
      @user = User.where(token: params[:user_token]).living.first
      @link = Link.where(user: @user, url: params[:url]).living.first if @user
    end
  end

  def keep
    unless params[:user_token].blank?
      @user = User.where(token: params[:user_token]).first
      if @user
        if params[:id]
          @link = Link.where(user: @user, id: params[:id]).first
        else
          @link = Link.where(user: @user, url: params[:url]).first
        end
        @link.keeped? ? @link.unkeep : @link.keep
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
