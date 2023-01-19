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

  describe "Class Methods" do 
    describe "::leaders" do 
      it "returns a list of 10 users with attributes miles, beers, carbon, username, and id sorted by total miles" do 
        users = []
        12.times { users << create(:user)}
        user1, user2, user3, user4, user5, user6, user7, user8, user9, user10, user11, user12 = users

        12.times { create(:activity, distance: 100, user: user5) }
        11.times { create(:activity, distance: 100, user: user6) }
        10.times { create(:activity, distance: 100, user: user11) }
        9.times { create(:activity, distance: 100, user: user3) }
        8.times { create(:activity, distance: 100, user: user9) }
        7.times { create(:activity, distance: 100, user: user1) }
        6.times { create(:activity, distance: 100, user: user8) }
        5.times { create(:activity, distance: 100, user: user10) }
        4.times { create(:activity, distance: 100, user: user7) }
        3.times { create(:activity, distance: 100, user: user4) }
        2.times { create(:activity, distance: 100, user: user12) }
        1.times { create(:activity, distance: 100, user: user2) }

        leaders = Activity.leaders 

        expect(leaders.length).to eq(10)

        leaders.each do |leader|
          expect(leader.username).to be_a(String)
          expect(leader.miles).to be_a(Float)
          expect(leader.beers).to be_an(Integer)
          expect(leader.carbon).to be_a(Float)
        end

        expect(leaders[0].username).to eq(user5.username)
        expect(leaders[0].miles).to eq(1200)

        expect(leaders[1].username).to eq(user6.username)
        expect(leaders[1].miles).to eq(1100)

        expect(leaders[2].username).to eq(user11.username)
        expect(leaders[2].miles).to eq(1000)

        expect(leaders[3].username).to eq(user3.username)
        expect(leaders[3].miles).to eq(900)

        expect(leaders.last.username).to eq(user4.username)
        expect(leaders.last.miles).to eq(300)
      end
    end
  end

  describe "Instance Methods" do 
    let(:response_body_1) { File.open('./spec/fixtures/sample_json/strava_activities.json')}
    let(:response_body_2) { File.open('./spec/fixtures/sample_json/strava_activity.json')}
    let(:response_body_3) { File.open('./spec/fixtures/sample_json/gas_buddy.json') }

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
    
        stub_request(:get, "https://www.strava.com/api/v3/athlete/activities?per_page=1")
          .with(headers: {"Authorization" => "Bearer #{user_token}"})
          .to_return(status: 200, body: response_body_1)
        
        stub_request(:get, "https://www.strava.com/api/v3/activities/154504250376823")
          .with(headers: {"Authorization" => "Bearer #{user_token}"})
          .to_return(status: 200, body: response_body_2)

        stub_request(:post, "https://www.gasbuddy.com/gaspricemap/county?lat=39.059811&lng=-105.311104&usa=true")
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
        activity_3 = create(:activity, calories: 402, drink_type: "Light Beer")

        expect(activity_1.calculate_num_drinks).to eq(5)
        expect(activity_2.calculate_num_drinks).to eq(1)
        expect(activity_3.calculate_num_drinks).to eq(4)
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