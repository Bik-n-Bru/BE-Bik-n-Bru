require 'rails_helper'

describe "Activity API" do
  let(:response_body_1) { File.open('./spec/fixtures/sample_json/strava_activities.json') }
  let(:response_body_2) { File.open('./spec/fixtures/sample_json/strava_activity.json') }
  let(:response_body_3) { File.open('./spec/fixtures/sample_json/gas_price.json') }

  it "can create an activity" do
    user = create(:user, state: "Colorado")
    user_id = user.id
    user_token = user.token

    stub_request(:get, "https://www.strava.com/athlete/activites?per_page=1")
      .with(headers: {"Authorization" => "Bearer #{user_token}"})
      .to_return(status: 200, body: response_body_1)
    
    stub_request(:get, "https://www.strava.com/activities/154504250376823")
      .with(headers: {"Authorization" => "Bearer #{user_token}"})
      .to_return(status: 200, body: response_body_2)
    
    stub_request(:get, "https://api.collectapi.com/gasPrice/stateUsaPrice?state=CO")
      .with(headers: {"authorization" => "apikey #{ENV['gas_key']}"})
      .to_return(status: 200, body: response_body_3)

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
    expect(new_activity.brewery_name).to eq("Name")
    expect(new_activity.distance).to eq(17.459909)
    expect(new_activity.calories).to eq(870)
    expect(new_activity.drink_type).to eq("IPA")
    expect(new_activity.num_drinks).to eq(3)
    expect(new_activity.dollars_saved).to eq(2.44)
    expect(new_activity.lbs_carbon_saved).to eq(15.71)
  end

  it "returns an error if there are missing attributes" do 
    user = create(:user, state: "Colorado")
    user_id = user.id
    user_token = user.token

    stub_request(:get, "https://www.strava.com/athlete/activites?per_page=1")
      .with(headers: {"Authorization" => "Bearer #{user_token}"})
      .to_return(status: 200, body: response_body_1)
    
    stub_request(:get, "https://www.strava.com/activities/154504250376823")
      .with(headers: {"Authorization" => "Bearer #{user_token}"})
      .to_return(status: 200, body: response_body_2)

    stub_request(:get, "https://api.collectapi.com/gasPrice/stateUsaPrice?state=CO")
      .with(headers: {"authorization" => "apikey #{ENV['gas_key']}"})
      .to_return(status: 200, body: response_body_3)

    activity_params = {
                        data: {
                          brewery_name: "Name",
                          user_id: user_id
                        }
                      }
    headers = {"CONTENT_TYPE" => "application/json"}

    expect(Activity.all.count).to eq(0)

    post "/api/v1/activities", headers: headers, params: JSON.generate(activity: activity_params)
    response_data = JSON.parse(response.body, symbolize_names: true)
    
    expect(Activity.all.count).to eq(0)
    expect(response.status).to eq(400)

    expect(response_data).to have_key(:message)
    expect(response_data[:message]).to eq("Record is missing one or more attributes")

    expect(response_data).to have_key(:errors)
    expect(response_data[:errors]).to eq(["Num drinks can't be blank","Drink type can't be blank"])
  end

  it "catches when there's no user ID and doesn't make the strava API call, but returns an error" do 
    user = create(:user, state: "Colorado")
    user_id = user.id
    user_token = user.token

    stub_request(:get, "https://www.strava.com/athlete/activites?per_page=1")
      .with(headers: {"Authorization" => "Bearer #{user_token}"})
      .to_return(status: 200, body: response_body_1)
    
    stub_request(:get, "https://www.strava.com/activities/154504250376823")
      .with(headers: {"Authorization" => "Bearer #{user_token}"})
      .to_return(status: 200, body: response_body_2)
    
      stub_request(:get, "https://api.collectapi.com/gasPrice/stateUsaPrice?state=CO")
      .with(headers: {"authorization" => "apikey #{ENV['gas_key']}"})
      .to_return(status: 200, body: response_body_3)

    activity_params = {
                        data: {
                          brewery_name: "Name",
                          drink_type: "IPA"
                        }
                      }
    headers = {"CONTENT_TYPE" => "application/json"}

    expect(Activity.all.count).to eq(0)

    post "/api/v1/activities", headers: headers, params: JSON.generate(activity: activity_params)
    response_data = JSON.parse(response.body, symbolize_names: true)
    
    expect(Activity.all.count).to eq(0)
    expect(response.status).to eq(400)

    expect(response_data).to have_key(:message)
    expect(response_data[:message]).to eq("Record is missing one or more attributes")

    expect(response_data).to have_key(:errors)
    expect(response_data[:errors]).to eq(["User must exist", "User can't be blank", "Distance can't be blank", "Calories can't be blank", "Num drinks can't be blank", "Dollars saved can't be blank", "Lbs carbon saved can't be blank"])
  end
end