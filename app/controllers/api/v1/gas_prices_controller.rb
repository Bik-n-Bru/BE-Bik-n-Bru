class Api::V1::GasPricesController < ApplicationController
  def show
    user = User.find(params[:user_id])
    
    if user.state.nil? || user.state.empty?
      render json: ErrorSerializer.missing_state, status: 400
    else
      abbreviation = StateSymbol.convert(user.state)
      gas_price = gas_service.get_gas_price(abbreviation)
      render json: GasPriceSerializer.serialize_gas_price(user.state, gas_price)
    end
  end

  def gas_service
    GasService.new
  end
end