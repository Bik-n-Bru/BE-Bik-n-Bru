class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)
    render json: UserSerializer.new(user)
  end

  private 

    def user_params
      params.require(:user).require(:data).permit(:username, :token, :athlete_id, :city, :state)
    end
end