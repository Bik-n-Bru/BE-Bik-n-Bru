class BadgeSerializer
  include JSONAPI::Serializer
  belongs_to :user
  attributes :title
end
