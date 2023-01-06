class ActivitySerializer
  include JSONAPI::Serializer
  belongs_to :user
  attributes :distance, :calories, :num_drinks, :drink_type, :brewery_name
end
