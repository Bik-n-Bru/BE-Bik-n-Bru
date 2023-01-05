class ActivitySerializer
  include JSONAPI::Serializer
  belongs_to :user
  attributes :brewery_id, :distance, :calories, :num_drinks, :drink_type, :brewery_name
end
