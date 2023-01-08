require "rails_helper"

describe "Badges API" do 
  it "can get the list of badges associated with a particular user" do 
    user = create(:user)
    5.times { create(:badge, user: user) }

    get "/api/v1/users/#{user.id}/badges" 

    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_body = JSON.parse(response.body, symbolize_names: true)

    badges = response_body[:data]

    expect(badges).to be_an(Array)

    badges.each do |badge|
      expect(badge).to be_a(Hash)
      expect(badge[:id]).to be_an(String)
      expect(badge[:type]).to eq("badge")
      expect(badge[:attributes]).to be_a(Hash)
      expect(badge[:attributes]).to have_key(:title)
      expect(badge[:attributes][:title]).to be_a(String)
      expect(badge[:relationships]).to have_key(:user)
      expect(badge[:relationships][:user][:data][:id]).to eq(user.id.to_s)
    end
  end

  it "returns an error if there is no user with that id" do 
    user = create(:user)
    5.times { create(:badge, user: user) }

    get "/api/v1/users/10000/badges"
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(404)

    expect(response_body[:message]).to eq("No record found")
    expect(response_body[:errors]).to eq("Couldn't find User with 'id'=10000")
  end
end