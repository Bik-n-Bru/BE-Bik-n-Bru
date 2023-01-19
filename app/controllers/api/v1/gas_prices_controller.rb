class Api::V1::GasPricesController < ApplicationController
  def show
    user = User.find(params[:user_id])
    
    if user.state.nil? || user.state.empty?
      render json: ErrorSerializer.missing_state, status: 400
    else
      lat_long_array = StateLatLong.convert(user.state)
      gas_price = gas_service.get_gas_price(lat_long_array)
      render json: GasPriceSerializer.serialize_gas_price(user.state, gas_price)
    end
  end

  def gas_service
    GasService.new
  end
end