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
            presence: true
  
  after_save :create_badges

  def get_attributes
    update_from_strava_service
    update_from_gas_service
  end

  def update_from_strava_service
    strava_activity = strava_service.get_latest_activity(user.token)
    self.distance = (strava_activity.distance_in_meters / 1609.344).round(6) 
    self.calories = strava_activity.calories 
    self.num_drinks = calculate_num_drinks
  end

  def update_from_gas_service
    abbreviation = StateSymbol.convert(user.state)
    gas_price = gas_service.get_gas_price(abbreviation)
    self.dollars_saved = ((self.distance / 22) * gas_price).round(2) 
    self.lbs_carbon_saved = (distance * 0.9).round(2)
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

  def strava_service 
    StravaService.new
  end

  def gas_service
    GasService.new
  end

  def create_badges
    user.create_badges
  end
end