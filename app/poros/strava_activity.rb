class StravaActivity
  attr_reader :calories, :distance_in_meters
  
  def initialize(data)
    @calories = data[:calories]
    @distance_in_meters = data[:distance]
  end
end