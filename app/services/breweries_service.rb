class BreweriesService
  def self.search_by_city_state(city, state)
    breweries = get_url("breweries?", city, state)
    breweries.map do |data|
      Brewery.new(data)
    end
  end

  def self.get_url(url, city, state)
    response = conn(city, state).get(url)
    parsed_response(response)
  end

  def self.conn(city, state)
    Faraday.new(url: "https://api.openbrewerydb.org/", 
      params: { "by_city": city, "by_state": state })
  end

  def self.parsed_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end