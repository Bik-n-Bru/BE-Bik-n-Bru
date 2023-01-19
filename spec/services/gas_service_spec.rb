require "rails_helper"

RSpec.describe GasService do 
  describe "Instance Methods" do 
    let(:service) { GasService.new }

    describe "#conn" do 
      it "creates a faraday connection" do 
        expect(service.conn).to be_a(Faraday::Connection)
      end
    end

    describe "#get_gas_price" do 
      it "returns a float of gas price for a given state" do 
        VCR.use_cassette('get_gas_price') do 
          gas_price = service.get_gas_price(['39.059811', '-105.311104'])

          expect(gas_price).to be_a(Float)
          expect(gas_price).to eq(3.478)
        end
      end
    end
  end
end