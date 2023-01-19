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