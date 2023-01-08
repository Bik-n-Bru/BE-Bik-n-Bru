class UserSerializer
  include JSONAPI::Serializer
  has_many :activities
  has_many :badges
  attributes :username, :token, :athlete_id, :city, :state
end