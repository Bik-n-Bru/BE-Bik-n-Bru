require "rails_helper"

describe "Open Brewery Api" do
  it 'can find breweries based on city and state' do
    VCR.use_cassette('bnb_breweries_in_Denver') do
      user = create(:user, username: "Billy", id: "10", city: "denver", state: "colorado")

      get "/api/v1/breweries/#{user.id}"
      expect(response).to be_successful
      expect(response.status).to eq(200)
    
      response_body = JSON.parse(response.body, symbolize_names: true)
      breweries = response_body[:data]
      
      expect(breweries.count).to eq(20)

      breweries.each do |brewery|
        expect(brewery).to have_key(:id)
        expect(brewery[:id]).to be_an(String)

        expect(brewery[:attributes]).to have_key(:name)
        expect(brewery[:attributes][:name]).to be_a(String) if !brewery[:attributes][:name].nil?
        expect(brewery[:attributes]).to have_key(:city) 
        expect(brewery[:attributes][:city]).to be_a(String) 
        expect(brewery[:attributes]).to have_key(:state) 
        expect(brewery[:attributes][:state]).to be_a(String) 
        expect(brewery[:attributes]).to have_key(:phone)
        expect(brewery[:attributes][:phone]).to be_a(String) if !brewery[:attributes][:phone].nil?
        expect(brewery[:attributes]).to have_key(:website_url)
        expect(brewery[:attributes][:website_url]).to be_a(String) if !brewery[:attributes][:website].nil?
      end
    end
  end
end