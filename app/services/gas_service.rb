class GasService 
  def conn 
    Faraday.new(url: "https://www.gasbuddy.com/")
  end

  def get_gas_price(lat_long_array)
    lat, long = lat_long_array
    response = conn.post("/gaspricemap/county?lat=#{lat}&lng=#{long}&usa=true")
    data = JSON.parse(response.body, symbolize_names: true)
    price = data[0][:Price]
  end
end

# class GasService 
#   def conn 
#     Faraday.new(url: "https://api.collectapi.com") do |req|
#       req.headers["authorization"] = "apikey #{ENV['gas_key']}"
#     end
#   end

#   def get_gas_price(state)
#     data = get_url("/gasPrice/stateUsaPrice?state=#{state}")
#     data[:result][:state][:gasoline].to_f
#   end

#   def get_url(url)
#     response = conn.get(url)
#     JSON.parse(response.body, symbolize_names: true)
#   end
# end