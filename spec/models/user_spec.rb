require "rails_helper"

RSpec.describe User, type: :model do 
  describe "Relationships" do 
    it { should have_many(:activities) }
  end

  describe "Validations" do 
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:token) }
    it { should validate_presence_of(:athlete_id) }
  end

  describe "instance methods" do 
    describe "#earn activity badges" do 
      it "creates activity badges for a user appropriately" do 
        user = create(:user)

        create(:activity, user: user)

        expect(user.badges.where(title: "Completed 1 Activity").count).to eq(1)

        49.times { create(:activity, user: user) }

        expect(user.badges.where(title: "Completed 1 Activity").count).to eq(1)
        expect(user.badges.where(title: "Completed 50 Activities").count).to eq(1)

        55.times { create(:activity, user: user) }

        expect(user.badges.where(title: "Completed 1 Activity").count).to eq(1)
        expect(user.badges.where(title: "Completed 50 Activities").count).to eq(1)
        expect(user.badges.where(title: "Completed 100 Activities").count).to eq(1)
      end
    end

    describe "#earn_mileage_badges" do 
      it "creates mileage badges for a user appropriately" do 
        user = create(:user)

        create(:activity, user: user, distance: 150)

        expect(user.badges.where(title: "Cycled 100 miles").count).to eq(1)
        
        create(:activity, user: user, distance: 400)

        expect(user.badges.where(title: "Cycled 100 miles").count).to eq(1)
        expect(user.badges.where(title: "Cycled 500 miles").count).to eq(1)

        create(:activity, user: user, distance: 1000)

        expect(user.badges.where(title: "Cycled 100 miles").count).to eq(1)
        expect(user.badges.where(title: "Cycled 500 miles").count).to eq(1)
        expect(user.badges.where(title: "Cycled 1000 miles").count).to eq(1)
      end
    end
  end
end