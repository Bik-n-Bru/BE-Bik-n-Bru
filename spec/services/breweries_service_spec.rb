require 'rails_helper'

describe 'Breweries Service' do
  it 'searches api for breweries by city and state' do
    VCR.use_cassette('breweries_in_denver') do

      city = "denver"
      state = "colorado"

      results = BreweriesService.get_url("breweries?", city, state)
      first_brewery = results.first

      expect(first_brewery).to have_key(:id)
      expect(first_brewery).to have_key(:name)
      expect(first_brewery).to have_key(:brewery_type)
      expect(first_brewery).to have_key(:street)
      expect(first_brewery).to have_key(:address_2)
      expect(first_brewery).to have_key(:address_3)
      expect(first_brewery).to have_key(:city)
      expect(first_brewery).to have_key(:state)
      expect(first_brewery).to have_key(:county_province)
      expect(first_brewery).to have_key(:postal_code)
      expect(first_brewery).to have_key(:country)
      expect(first_brewery).to have_key(:longitude)
      expect(first_brewery).to have_key(:latitude)
      expect(first_brewery).to have_key(:phone)
      expect(first_brewery).to have_key(:website_url)
      expect(first_brewery).to have_key(:updated_at)
      expect(first_brewery).to have_key(:created_at)
      expect(first_brewery).to eq({
        :id=>"10-barrel-brewing-co-denver-denver",
        :name=>"10 Barrel Brewing Co - Denver",
        :brewery_type=>"large",
        :street=>"2620 Walnut St",
        :address_2=>nil,
        :address_3=>nil,
        :city=>"Denver",
        :state=>"Colorado",
        :county_province=>nil,
        :postal_code=>"80205-2231",
        :country=>"United States",
        :longitude=>"-104.9853655",
        :latitude=>"39.7592508",
        :phone=>"7205738992",
        :website_url=>nil,
        :updated_at=>"2023-01-04T04:46:02.393Z",
        :created_at=>"2023-01-04T04:46:02.393Z"})
    end
  end

  it "only returns brewries in that city/state" do 
    VCR.use_cassette("city_state_check_for_breweries") do 
      results = BreweriesService.search_by_city_state("Bend", "Oregon")

      results.each do |result|
        expect(result.city).to eq("Bend")
        expect(result.state).to eq("Oregon")
      end
    end
  end
end