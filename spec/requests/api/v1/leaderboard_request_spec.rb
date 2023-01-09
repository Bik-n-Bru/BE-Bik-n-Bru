require "rails_helper"

RSpec.describe "Leaderboard Request" do 
  it "will return the top ten users (by mileage) and include information like (total miles, total CO2, username, total beers drunk, etc." do 
    20.times do 
      create(:user) do |user|
        create_list(:activity, 50, user: user)
      end
    end
    
    get '/api/v1/leaderboard'

    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_body = JSON.parse(response.body, symbolize_names: true)

    leaders = response_body[:data]

    expect(leaders).to be_an(Array)

    leaders.each do |leader|
      expect(leader).to be_a(Hash)
      expect(leader[:id]).to be_an(String)
      expect(leader[:type]).to eq("leader")
      expect(leader[:attributes]).to be_a(Hash)
      expect(leader[:attributes]).to have_key(:username)
      expect(leader[:attributes][:username]).to be_a(String)
      expect(leader[:attributes]).to have_key(:total_miles)
      expect(leader[:attributes][:total_miles]).to be_a(Float)
      expect(leader[:attributes]).to have_key(:total_beers)
      expect(leader[:attributes][:total_beers]).to be_a(Integer)
      expect(leader[:attributes]).to have_key(:total_carbon)
      expect(leader[:attributes][:total_carbon]).to be_a(Float)
    end
  end
end