require "rails_helper"

describe "Users API" do 
  xit "can find a user by their strava athlete_id and returns a single user" do 
    athlete_id = create(:user).athlete_id

    get "/api/v1/users/#{athlete_id}"

    user = JSON.parse(response.body, symbolize_names: true)
  end

  it "can create a user and allows empty string attributes for city/state" do 
    user_params = { 
                    data: {
                      athlete_id: '12345',
                      username: 'testcase',
                      token: '12345abcde',
                      city: '',
                      state: ''
                    }
                  }
    headers = {"CONTENT_TYPE" => "application/json"}

    expect(User.all.count).to eq(0)

    post "/api/v1/users", headers: headers, params: JSON.generate(user: user_params)
    created_user = User.last

    expect(User.all.count).to eq(1)
    expect(response).to be_successful 
    expect(created_user.username).to eq(user_params[:data][:username])
    expect(created_user.city).to eq(user_params[:data][:city])
    expect(created_user.state).to eq(user_params[:data][:state])
    expect(created_user.athlete_id).to eq(user_params[:data][:athlete_id])
    expect(created_user.token).to eq(user_params[:data][:token])
  end

  it "ignores attributes that are not allowed" do 
    user_params = { 
                    data: {
                      athlete_id: '12345',
                      username: 'testcase',
                      token: '12345abcde',
                      city: 'Denver',
                      state: 'Colorado',
                      total_mileage: '8435093124',
                      date_registered: '12-12-2022'
                    }
                  }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/users", headers: headers, params: JSON.generate(user: user_params)
    
    user_data = JSON.parse(response.body, symbolize_names: true)

    created_user = User.last

    expect(User.all.count).to eq(1)
    expect(user_data[:data][:attributes]).to_not have_key(:total_mileage)
    expect(user_data[:data][:attributes]).to_not have_key(:date_registered)

    expect(response).to be_successful 
    expect(created_user.username).to eq(user_params[:data][:username])
    expect(created_user.city).to eq(user_params[:data][:city])
    expect(created_user.state).to eq(user_params[:data][:state])
    expect(created_user.athlete_id).to eq(user_params[:data][:athlete_id])
    expect(created_user.token).to eq(user_params[:data][:token])
  end

  it "returns an error if a required attribute is missing" do 
    user_params = { 
                    data: {
                      athlete_id: '12345',
                    }
                  }
    headers = {"CONTENT_TYPE" => "application/json"}
    expect(User.all.count).to eq(0)

    post "/api/v1/users", headers: headers, params: JSON.generate(user: user_params)
    
    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(User.all.count).to eq(0)
    expect(response.status).to eq(400)

    expect(response_data).to have_key(:message)
    expect(response_data[:message]).to eq("Record is missing one or more attributes")

    expect(response_data).to have_key(:errors)
    expect(response_data[:errors]).to eq(["Username can't be blank", "Token can't be blank"])
  end
end