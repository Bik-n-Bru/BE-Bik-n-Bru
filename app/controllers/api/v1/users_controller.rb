class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save 
      render json: UserSerializer.new(user)
    else 
      render json: ErrorSerializer.missing_attributes(user.errors.full_messages), status: :bad_request
    end
  end

  private 

    def user_params
      params.require(:user).require(:data).permit(:username, :token, :athlete_id, :city, :state)
    end
end