class Api::V1::GasPricesController < ApplicationController
  def show
    user = User.find(params[:user_id])
    abbreviation = StateSymbol.convert(user.state)
    gas_price = gas_service.get_gas_price(abbreviation)

    render json: GasPriceSerializer.serialize_gas_price(user.state, gas_price)
  end

  def gas_service
    GasService.new
  end
end