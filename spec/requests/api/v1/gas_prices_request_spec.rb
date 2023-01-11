require 'rails_helper'

RSpec.describe 'Gas Price Request' do
  it "returns the gas price for a user's state" do
    user = create(:user)
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
end