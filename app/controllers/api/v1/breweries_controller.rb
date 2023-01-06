class Api::V1::BreweriesController < ApplicationController
  def search
    user = User.find(params[:user_id])
    city = user.city
    state = user.state
    render json: BreweriesService.search_by_city_state(city, state), status: 200
  end
end
