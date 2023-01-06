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
  end
end