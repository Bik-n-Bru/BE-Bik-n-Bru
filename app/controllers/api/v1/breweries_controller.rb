class Api::V1::BreweriesController < ApplicationController
  def search
    user = User.find(params[:user_id])
    city, state = [user.city, user.state]
    breweries = BreweriesService.search_by_city_state(city, state)
    render json: BrewerySerializer.new(breweries), status: 200
  end
end
