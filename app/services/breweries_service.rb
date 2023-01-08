class BreweriesService
  def self.search_by_city_state(city, state)
    breweries = get_url("breweries?", city, state)
    breweries.map do |data|
      Brewery.new(data)
    end
  end

  def self.get_url(url, city, state)
    response = conn.get(url) do |req|
      req.params[:by_city] = city 
      req.params[:by_state] = state
      req.params[:per_page] = 50
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "https://api.openbrewerydb.org/")
  end
end