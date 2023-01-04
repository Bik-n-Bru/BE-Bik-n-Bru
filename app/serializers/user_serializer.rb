class UserSerializer
  include JSONAPI::Serializer
  attributes :username, :token, :athlete_id, :city, :state
end