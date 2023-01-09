class LeaderboardSerializer
  def initialize(leaders)
    {
      "data": {
        leaders.each do |leader|
          {
            "id": "#{leader.id}",
            "type": "leader".
            "attributes": {
              "username": "#{leader.username}",
              "total_miles": "#{leader.total_miles}",
              "total_beers": "#{leader.total_beers}",
              "total_carbon": "#{leader.total_carbon}"
            }
          }
        end
      }
    }
  end
end