class LeaderboardSerializer
  def self.list(leaders)
    {
      "data": self.leaders_list(leaders)
    }
  end

  def self.leaders_list(leaders)
    leaders.each_with_object([]) do |leader, list|
      leader = {
        "id": "#{leader.id}",
        "type": "leader",
        "attributes": {
          "username": "#{leader.username}",
          "miles": leader.miles,
          "beers": leader.beers,
          "co2_saved": leader.carbon
        }
      }
      list << leader
    end
  end
end