require 'rails_helper'

describe "Activity API" do
  let(:response_body_1) { File.open('./spec/fixtures/sample_json/strava_activities.json') }
  let(:response_body_2) { File.open('./spec/fixtures/sample_json/strava_activity.json') }
  let(:response_body_3) { File.open('./spec/fixtures/sample_json/gas_price.json') }

  it "can create an activity" do
    user = create(:user, state: "Colorado")
    user_id = user.id
    user_token = user.token

    stub_request(:get, "https://www.strava.com/api/v3/athlete/activities?per_page=1")
      .with(headers: {"Authorization" => "Bearer #{user_token}"})
      .to_return(status: 200, body: response_body_1)
    
    stub_request(:get, "https://www.strava.com/api/v3/activities/154504250376823")
      .with(headers: {"Authorization" => "Bearer #{user_token}"})
      .to_return(status: 200, body: response_body_2)
    
    stub_request(:get, "https://api.collectapi.com/gasPrice/stateUsaPrice?state=CO")
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

    stub_request(:get, "https://www.strava.com/api/v3/athlete/activities?per_page=1")
      .with(headers: {"Authorization" => "Bearer #{user_token}"})
      .to_return(status: 200, body: response_body_1)
    
    stub_request(:get, "https://www.strava.com/api/v3/activities/154504250376823")
      .with(headers: {"Authorization" => "Bearer #{user_token}"})
      .to_return(status: 200, body: response_body_2)

    stub_request(:get, "https://api.collectapi.com/gasPrice/stateUsaPrice?state=CO")
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

    stub_request(:get, "https://www.strava.com/api/v3/athlete/activities?per_page=1")
      .with(headers: {"Authorization" => "Bearer #{user_token}"})
      .to_return(status: 200, body: response_body_1)
    
    stub_request(:get, "https://www.strava.com/api/v3/activities/154504250376823")
      .with(headers: {"Authorization" => "Bearer #{user_token}"})
      .to_return(status: 200, body: response_body_2)
    
      stub_request(:get, "https://api.collectapi.com/gasPrice/stateUsaPrice?state=CO")
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

  it 'can return a list of all activities for a given user' do
    user1 = create(:user, state: "Colorado")
    user2 = create(:user, state: "Arizona")
    create_list(:activity, 15, user: user1)
    create_list(:activity, 10, user: user2)

    get "/api/v1/users/#{user1.id}/activities"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)

    activities = response_body[:data]

    expect(activities.count).to eq(15)

    activities.each do |activity|
      expect(activity).to have_key(:id)
      expect(activity[:id]).to be_an(String)

      expect(activity).to have_key(:attributes)
      expect(activity[:attributes][:brewery_name]).to be_a(String)
      expect(activity[:attributes][:distance]).to be_a(Float)
      expect(activity[:attributes][:calories]).to be_a(Integer)
      expect(activity[:attributes][:num_drinks]).to be_a(Integer)
      expect(activity[:attributes][:drink_type]).to be_a(String)
      expect(activity[:attributes][:dollars_saved]).to be_a(Float)
      expect(activity[:attributes][:lbs_carbon_saved]).to be_a(Float)
      expect(activity[:attributes][:user_id]).to be_a(Integer)
    end
  end

  it 'can get a single activity for a given user' do
    user = create(:user, state: "Colorado")
    activity1 = create(:activity, user: user)
    activity1_id = activity1.id.to_s

    get "/api/v1/activities/#{activity1_id}"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
  
    activity = response_body[:data]

    expect(activity).to have_key(:id)
    expect(activity[:id]).to eq(activity1_id)

    expect(activity).to have_key(:attributes)
    expect(activity[:attributes][:brewery_name]).to be_a(String)
    expect(activity[:attributes][:distance]).to be_a(Float)
    expect(activity[:attributes][:calories]).to be_a(Integer)
    expect(activity[:attributes][:num_drinks]).to be_a(Integer)
    expect(activity[:attributes][:drink_type]).to be_a(String)
    expect(activity[:attributes][:dollars_saved]).to be_a(Float)
    expect(activity[:attributes][:lbs_carbon_saved]).to be_a(Float)
    expect(activity[:attributes][:user_id]).to be_a(Integer)
  end

  it 'returns an error if there is no activity' do
    user = create(:user, state: "Colorado")
    create_list(:activity, 25, user: user)
    activity_id = "999999999"

    get "/api/v1/activities/#{activity_id}"

    response_data = JSON.parse(response.body, symbolize_names: true)
    require 'pry'; binding.pry
    expect(response.status).to eq(400)

    expect(response_data).to have_key(:message)
    expect(response_data[:message]).to eq("Record is missing one or more attributes")

    expect(response_data).to have_key(:errors)
    expect(response_data[:errors]).to eq(["User must exist", "User can't be blank", "Distance can't be blank", "Calories can't be blank", "Num drinks can't be blank", "Dollars saved can't be blank", "Lbs carbon saved can't be blank"])
  end
end