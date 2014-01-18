class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def auth
    unless params[:email].blank? || params[:password].blank?
      @user = User.where(email: params[:email]).first
      if @user && @user.authenticated?(params[:password])
        session[:user_id] = @user.id
        #@user.avatar = Gravatar.new(@user.email).image_url
      else
        @user = nil
      end
    end
    respond_to do |format|
      format.html {
        if @user.nil?
          return redirect_to root_path, alert: 'Error, wrong email or password.'
        else
          return redirect_to root_path, notice: 'Nice to see you again.'
        end
      }
      format.json { render 'auth', type: :jbuilder }
    end
  end

  def create
    @user = User.new(email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
    end
    respond_to do |format|
      format.html {
        if @user.nil?
          return redirect_to signin_users_path, alert: 'Error, wrong email or password.'
        else
          return redirect_to root_path, notice: 'Nice to see you again.'
        end
      }
      format.json { render 'auth', type: :jbuilder }
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => 'Thank you, see you soon!'
  end

end
