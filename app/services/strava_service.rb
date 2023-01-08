class StravaService
  def conn(user_token) 
    Faraday.new(url: "https://www.strava.com") do |req|
      req.headers["Authorization"] = "Bearer #{user_token}"
    end
  end

  def get_latest_activity(user_token)
    data = get_url('/api/v3/athlete/activities?per_page=1', user_token).first
    activity_id = data[:id]
    data = get_url("/api/v3/activities/#{activity_id}", user_token)
    StravaActivity.new(data)
  end

  def get_url(url, user_token)
    response = conn(user_token).get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end 