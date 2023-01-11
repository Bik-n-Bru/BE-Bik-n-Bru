require 'rails_helper'

RSpec.describe 'Gas Price Request' do
  it "returns the gas price for a user's state" do
    user = create(:user, state: "Florida")
    VCR.use_cassette('get_user_gas_price') do
      get "/api/v1/gas_price/#{user.id}"
  
      expect(response).to be_successful
      expect(response.status).to eq(200)
  
      response_body = JSON.parse(response.body, symbolize_names: true)
  
      expect(response_body[:data]).to be_a Hash
      expect(response_body[:data]).to have_key(:state)
      expect(response_body[:data]).to have_key(:gas_price)
    end
  end

  it 'returns an error and 400 status if the user has not setup a state' do
    user = User.create!(username: 'Stateless Vagabond', token: 123, athlete_id: 5)
    get "/api/v1/gas_price/#{user.id}"

    expect(response.status).to eq(400)

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response_body[:message]).to eq("Request is missing necessary information")
    expect(response_body[:errors]).to eq(["The user has not provided a valid State"])
  end
end