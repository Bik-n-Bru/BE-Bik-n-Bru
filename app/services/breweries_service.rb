class BreweriesService
  def self.search_by_city_state(city, state)
    conn = Faraday.new(url: "https://api.openbrewerydb.org/", 
      params: { "by_city": "#{city}", "by_state": "#{state}" })
    
    response = conn.get("breweries?")

    JSON.parse(response.body, symbolize_names: true)
  end
end