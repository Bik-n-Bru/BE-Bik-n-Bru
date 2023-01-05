class Api::V1::UsersController < ApplicationController
  def create
    user = User.find_or_create_by(athlete_id: user_params[:athlete_id])
    user.username = user_params[:username]
    user.token = user_params[:token]
    user.athlete_id = user_params[:athlete_id]
    if user.save 
      render json: UserSerializer.new(user), status: :created
    else 
      render json: ErrorSerializer.missing_attributes(user.errors.full_messages), status: :bad_request
    end
  end

  def show
    if params[:q] == "athlete_id"
      user = User.find_by_athlete_id(params[:id]) 
    else
      user = User.find(params[:id])
    end
    render json: UserSerializer.new(user), status: 200
  end

  def update
    render json: UserSerializer.new(User.update(params[:id], user_params))
  end

  private 

    def user_params
      params.require(:user).require(:data).permit(:username, :token, :athlete_id, :city, :state)
    end
end