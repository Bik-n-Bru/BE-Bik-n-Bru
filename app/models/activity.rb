class Activity < ApplicationRecord
  belongs_to :user
  validates :user_id, 
            :distance, 
            :calories, 
            :num_drinks, 
            :drink_type, 
            :brewery_name, 
            :dollars_saved, 
            :lbs_carbon_saved, 
            :strava_activity_id,
            presence: true
  
  after_save :create_badges

  def get_attributes
    update_from_strava_service
    if update_from_strava_service.nil?
      nil
    else
      update_from_gas_service
    end
  end

  def update_from_strava_service
    strava_activity = strava_service.get_latest_activity(user.token)
    if strava_activity.nil?
      nil
    else
      self.distance = (strava_activity.distance_in_meters / 1609.344).round(6) 
      self.calories = strava_activity.calories 
      self.num_drinks = calculate_num_drinks
      self.strava_activity_id = strava_activity.id
    end
  end

  def update_from_gas_service
    lat_long_array = StateLatLong.convert(user.state)
    gas_price = gas_service.get_gas_price(lat_long_array)
    # 22 is average mpg of US car
    self.dollars_saved = ((self.distance / 22) * gas_price).round(2) 
    self.lbs_carbon_saved = (distance * 0.9).round(2)
  end

  def calculate_num_drinks
    case drink_type
    when "IPA"
      beer_calories = 300.0
    when "Pilsner"
      beer_calories = 200.0
    when "Light Beer"
      beer_calories = 104.0
    end
    (self.calories / beer_calories).round unless drink_type.nil?
  end

  def strava_service 
    StravaService.new
  end

  def gas_service
    GasService.new
  end

  def create_badges
    user.create_badges
  end

  def self.leaders
    self
      .joins(:user)
      .group("users.id")
      .select("sum(activities.num_drinks) as beers, sum(activities.lbs_carbon_saved) as carbon, sum(distance) as miles, users.username")
      .order(miles: :desc)
      .limit(10)
  end
end