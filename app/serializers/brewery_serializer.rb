class BrewerySerializer
  include JSONAPI::Serializer

  attributes :name, :street_address, :city, :state, :zipcode, :phone, :website_url
end