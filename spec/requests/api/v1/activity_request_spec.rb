require 'rails_helper'

describe "Activity API" do
  let(:response_body_1) { File.open('./spec/fixtures/sample_json/strava_activities.json')}
  let(:response_body_2) { File.open('./spec/fixtures/sample_json/strava_activity.json')}

  it "can create an activity" do
    user = create(:user)
    user_id = user.id
    user_token = user.token

    stub_request(:get, "https://www.strava.com/athlete/activites?per_page=1")
      .with(headers: {"Authorization" => "Bearer #{user_token}"})
      .to_return(status: 200, body: response_body_1)
    
    stub_request(:get, "https://www.strava.com/activities/154504250376823")
      .with(headers: {"Authorization" => "Bearer #{user_token}"})
      .to_return(status: 200, body: response_body_2)

    activity_params = {
                        data: {
                          brewery_name: "Name",
                          drink_type: "IPA",
                          user_id: "#{user_id}"
                        }
                      }
    headers = {"CONTENT_TYPE" => "application/json"}

    expect(Activity.all.count).to eq(0)

    post "/api/v1/activities", headers: headers, params: JSON.generate(activity: activity_params)
    
    new_activity = Activity.last

    expect(Activity.all.count).to eq(1)
    expect(new_activity.user_id).to eq(user_id)
    expect(new_activity.brewery_id).to eq("1234")
    expect(new_activity.brewery_name).to eq("Name")
    expect(new_activity.distance).to eq(45220957.056)
    expect(new_activity.calories).to eq(870.2)
    expect(new_activity.drink_type).to eq("IPA")
    expect(new_activity.num_drinks).to eq(3)
  end
end