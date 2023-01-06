class Brewery
  attr_reader :id, :name, :street_address, :city, :state, :zipcode, :phone, :website_url
   
  def initialize(data)
    @id = data[:id]
    @name = data[:name]
    @street_address = data[:street]
    @city = data[:city]
    @state = data[:state]
    @zipcode = data[:postal_code]
    @phone = data[:phone]
    @website_url = data[:website_url]
  end
end