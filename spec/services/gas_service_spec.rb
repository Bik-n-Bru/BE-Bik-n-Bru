require "rails_helper"

RSpec.describe GasService do 
  describe "Instance Methods" do 
    let(:service) { GasService.new }

    describe "#conn" do 
      it "creates a faraday connection" do 
        expect(service.conn).to be_a(Faraday::Connection)
      end
    end

    describe "#get_url" do
      it "returns a parsed json for the given url" do 
        VCR.use_cassette('gas_get_url') do 
          parsed = service.get_url('/gasPrice/stateUsaPrice?state=HI')

          expect(parsed).to be_a(Hash)

          expect(parsed).to have_key(:result)
          expect(parsed[:result]).to be_a(Hash)

          expect(parsed[:result]).to have_key(:state)
          expect(parsed[:result][:state]).to be_a(Hash)

          expect(parsed[:result][:state]).to have_key(:gasoline)
          expect(parsed[:result][:state][:gasoline]).to be_a(String)
        end
      end
    end

    describe "#get_gas_price" do 
      it "returns a float = gas price for a given state" do 
        VCR.use_cassette('get_gas_price') do 
          gas_price = service.get_gas_price("CO")

          expect(gas_price).to be_a(Float)
          expect(gas_price).to eq(3.079)
        end
      end
    end
  end
end