class UserSerializer
  include JSONAPI::Serializer
  has_many :activities
  attributes :username, :token, :athlete_id, :city, :state
end