class Activity < ApplicationRecord
  belongs_to :user

  validates :user_id, :distance, :calories, :num_drinks, :drink_type, :brewery_name, presence: true

  def get_attributes
    strava_activity = service.get_latest_activity(user.token)
    self.distance = strava_activity.distance_in_meters / 1609.344 
    self.calories = strava_activity.calories 
    self.num_drinks = calculate_num_drinks
  end

  def calculate_num_drinks
    case drink_type
    when "IPA"
      beer_calories = 300.0
    when "Pilsner"
      beer_calories = 250.0
    end
    (self.calories / beer_calories).round unless drink_type.nil?
  end

  def service 
    StravaService.new
  end
end