class Api::V1::UsersController < ApplicationController

  def index
    @users = User.all
    render json: @users
  end

  def signin
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      render json: {email: @user.email, token: issue_token({id: @user.id})}
    else
      render json: {error: "email/password combination invalid."}, status: 401
    end
  end

  def validate
    @user = get_current_user
    if @user
      render json: {email: @user.email, token: issue_token({id: @user.id})}
    else
      render json: {error: "email/password combination invalid."}, status: 401
    end
  end

  def get_journeys
    @user = get_current_user
    if @user
      render json: @user.journeys
    else
      render json: {error: "Not a valid user."}, status: 401
    end
  end
end
