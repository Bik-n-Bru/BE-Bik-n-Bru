class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save 
      render json: UserSerializer.new(user)
    else 
      render json: ErrorSerializer.missing_attributes(user.errors.full_messages), status: :bad_request
    end
  end

  def show
    user = User.find_by_athlete_id(params[:id]) 
    render json: UserSerializer.new(user), status: 200
  end

  private 

    def user_params
      params.require(:user).require(:data).permit(:username, :token, :athlete_id, :city, :state)
    end
end