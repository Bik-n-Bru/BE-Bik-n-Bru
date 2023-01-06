require "rails_helper"

RSpec.describe Activity, type: :model do 
  describe "Relationships" do 
    it { should belong_to(:user) }
  end

  describe "Validations" do
    it { should validate_presence_of(:user_id)}
    it { should validate_presence_of(:distance)}
    it { should validate_presence_of(:calories)}
    it { should validate_presence_of(:num_drinks)}
    it { should validate_presence_of(:drink_type)}
    it { should validate_presence_of(:brewery_name)}
    it { should validate_presence_of(:dollars_saved)}
    it { should validate_presence_of(:lbs_carbon_saved)}
  end

  describe "Instance Methods" do 
    let(:response_body_1) { File.open('./spec/fixtures/sample_json/strava_activities.json')}
    let(:response_body_2) { File.open('./spec/fixtures/sample_json/strava_activity.json')}
    let(:response_body_3) { File.open('./spec/fixtures/sample_json/gas_price.json') }

    describe "#get_attributes" do 
      it "should update the distance, calories, and num_drinks attributes for the instance of activity" do 
        user = create(:user, state: "Colorado")
        user_id = user.id
        user_token = user.token
        activity_params =  {
                              brewery_name: "Name",
                              drink_type: "IPA",
                              user_id: "#{user_id}"
                           }
    
        stub_request(:get, "https://www.strava.com/athlete/activites?per_page=1")
          .with(headers: {"Authorization" => "Bearer #{user_token}"})
          .to_return(status: 200, body: response_body_1)
        
        stub_request(:get, "https://www.strava.com/activities/154504250376823")
          .with(headers: {"Authorization" => "Bearer #{user_token}"})
          .to_return(status: 200, body: response_body_2)

        stub_request(:get, "https://api.collectapi.com/gasPrice/stateUsaPrice?state=CO")
          .to_return(status: 200, body: response_body_3)
        
        activity = Activity.new(activity_params)

        expect(activity.distance).to eq(nil)
        expect(activity.calories).to eq(nil)
        expect(activity.num_drinks).to eq(nil)

        activity.get_attributes

        expect(activity.distance).to eq(17.459909)
        expect(activity.calories).to eq(870)
        expect(activity.num_drinks).to eq(3)
      end
    end

    describe "#calculate_num_drinks" do 
      it "should return the rounded number of drinks based on the activities attributes" do 
        activity_1 = create(:activity, calories: 980, drink_type: "Pilsner")
        activity_2 = create(:activity, calories: 402, drink_type: "IPA")

        expect(activity_1.calculate_num_drinks).to eq(4)
        expect(activity_2.calculate_num_drinks).to eq(1)
      end
    end

    describe "#strava_service" do 
      it "returns a new instance of StravaService" do 
        activity = create(:activity)

        expect(activity.strava_service).to be_an_instance_of(StravaService)
      end
    end

    describe "#create_badges" do 
      it "will create badges for the user if they've earned them" do 
        user = create(:user)

        expect(user.badges).to be_empty

        5.times do 
          create(:activity, user: user, distance: 5)
        end

        expect(user.badges.count).to eq(1)

        create(:activity, user: user, distance: 90)

        expect(user.badges.count).to eq(2)

        4.times do 
          create(:activity, user: user, distance: 5)
        end

        expect(user.badges.count).to eq(3)
        expect(user.badges.pluck(:title)).to eq(["Completed 1 Activity", "Cycled 100 miles", "Visited 10 breweries"])
      end
    end
  end
end