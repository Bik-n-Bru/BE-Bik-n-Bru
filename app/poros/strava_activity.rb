class StravaActivity
  attr_reader :calories, :distance_in_meters, :id
  
  def initialize(data)
    @calories = data[:calories]
    @distance_in_meters = data[:distance]
    @id = data[:id]
  end
end