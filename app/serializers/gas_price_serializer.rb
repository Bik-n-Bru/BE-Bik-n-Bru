class GasPriceSerializer
  def self.serialize_gas_price(state, gas_price)
    {
      data: {
        state: state,
        gas_price: gas_price
      }
    }
  end
end