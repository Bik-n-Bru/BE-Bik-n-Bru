class ActivitySerializer
  include JSONAPI::Serializer
  belongs_to :user
  attributes :brewery_name, :distance, :calories, :num_drinks, :drink_type, :dollars_saved, :lbs_carbon_saved, :created_at, :user_id
end
