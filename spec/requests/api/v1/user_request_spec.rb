require "rails_helper"

describe "Users API" do 
  it "can find a user by their strava athlete_id and returns a single user" do 
    athlete_id = 22
    athlete = create(:user, athlete_id: athlete_id)
    
    get "/api/v1/users/#{athlete_id}?q=athlete_id"
 
    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_body = JSON.parse(response.body, symbolize_names: true)

    user = response_body[:data]
   
    expect(user[:attributes]).to have_key(:username)
    expect(user[:attributes]).to have_key(:token)
    expect(user[:attributes]).to have_key(:athlete_id)
    expect(user[:attributes]).to have_key(:city)
    expect(user[:attributes]).to have_key(:state)
    expect(user[:attributes][:username]).to be_a(String)
    expect(user[:attributes][:username]).to eq(athlete.username)
    expect(user[:attributes][:token]).to be_a(String)
    expect(user[:attributes][:token]).to eq(athlete.token)
    expect(user[:attributes][:athlete_id]).to be_a(String)
    expect(user[:attributes][:athlete_id]).to eq(athlete.athlete_id)
    expect(user[:attributes][:city]).to be_a(String)
    expect(user[:attributes][:city]).to eq(athlete.city)
    expect(user[:attributes][:state]).to be_a(String)
    expect(user[:attributes][:state]).to eq(athlete.state)
  end

  it "can find a user by their bnb id and returns a single user" do 
    athlete = create(:user)
    id = athlete.id
    
    get "/api/v1/users/#{id}"
 
    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_body = JSON.parse(response.body, symbolize_names: true)

    user = response_body[:data]
   
    expect(user[:attributes]).to have_key(:username)
    expect(user[:attributes]).to have_key(:token)
    expect(user[:attributes]).to have_key(:athlete_id)
    expect(user[:attributes]).to have_key(:city)
    expect(user[:attributes]).to have_key(:state)
    expect(user[:attributes][:username]).to be_a(String)
    expect(user[:attributes][:username]).to eq(athlete.username)
    expect(user[:attributes][:token]).to be_a(String)
    expect(user[:attributes][:token]).to eq(athlete.token)
    expect(user[:attributes][:athlete_id]).to be_a(String)
    expect(user[:attributes][:athlete_id]).to eq(athlete.athlete_id)
    expect(user[:attributes][:city]).to be_a(String)
    expect(user[:attributes][:city]).to eq(athlete.city)
    expect(user[:attributes][:state]).to be_a(String)
    expect(user[:attributes][:state]).to eq(athlete.state)
  end

  it "can create a user" do 
    user_params = { 
                    data: {
                      athlete_id: '12345',
                      username: 'testcase',
                      token: '12345abcde'
                    }
                  }
    headers = {"CONTENT_TYPE" => "application/json"}

    expect(User.all.count).to eq(0)

    post "/api/v1/users", headers: headers, params: JSON.generate(user: user_params)
    created_user = User.last

    expect(User.all.count).to eq(1)
    expect(response).to be_successful 
    expect(response.status).to eq(200)

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
                      token: '12345abcde'
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

  it "doesn't create a user if that user's athlete_id already exists" do 
    athlete_id = 1344556
    athlete = create(:user, athlete_id: athlete_id)
    user_params = { 
                    data: {
                      athlete_id: '1344556',
                      username: 'testcase',
                      token: '12345abcde'
                    }
                  }
    headers = {"CONTENT_TYPE" => "application/json"}

    expect(User.all.count).to eq(1)

    post "/api/v1/users", headers: headers, params: JSON.generate(user: user_params)

    expect(User.all.count).to eq(1)
    expect(response).to be_successful 
  end

  it "can edit an existing user" do 
    user_id = create(:user).id
    previous_city = User.last.city
    previous_state = User.last.state

    user_params = {
                    data: {
                      city: "Not a real city",
                      state: "Not a state"
                    }
                  }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/users/#{user_id}", headers: headers, params: JSON.generate(user: user_params)

    user = User.find(user_id)

    expect(response).to be_successful
    expect(user.city).to_not eq(previous_city)
    expect(user.city).to eq("Not a real city")
    expect(user.state).to_not eq(previous_state)
    expect(user.state).to eq("Not a state")
  end
end