class BrewerySerializer
  include JSONAPI::Serializer
  attributes :name, :city, :state, :website_url
end