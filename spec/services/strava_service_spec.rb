require "rails_helper"

RSpec.describe StravaService do 
  describe "Instance Methods" do 
    let(:service) { StravaService.new }
    let(:user) { create(:user, token: '96c401bc3baf0c0d272c30c473cf06bded9ad3ba')}
    
    describe "#conn" do 
      it "creates a Faraday connection to www.strava.com" do 
        conn = service.conn(user.token)
        expect(conn).to be_a(Faraday::Connection)
      end
    end

    describe "#get_latest_activity" do 
      it "returns a StravaActivity object (the most recent for that user)" do 
        VCR.use_cassette('get_latest_activity') do 
          activity = service.get_latest_activity(user.token)

          expect(activity).to be_a(StravaActivity)
          expect(activity.calories).to eq(277.0)
          expect(activity.distance_in_meters).to eq(5016.0)
        end
      end
    end

    describe "#get_url" do 
      it "returns a parsed, symbolized json response for a given url call" do 
        VCR.use_cassette('strava_get_url') do 
          parsed = service.get_url('/api/v3/athlete', user.token)

          expect(parsed).to be_a(Hash)

          expect(parsed).to have_key(:id)
          expect(parsed[:id]).to be_an(Integer)

          expect(parsed).to have_key(:firstname)
          expect(parsed[:firstname]).to be_a(String)

          expect(parsed).to have_key(:lastname)
          expect(parsed[:lastname]).to be_a(String)
        end
      end
    end
  end
end