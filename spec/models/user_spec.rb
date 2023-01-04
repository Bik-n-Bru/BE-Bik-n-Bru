require "rails_helper"

RSpec.describe User, type: :model do 
  describe "Relationships" do 
    it { should have_many(:activities) }
  end

  describe "Validations" do 
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:token) }
    it { should validate_presence_of(:athlete_id) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
  end
end