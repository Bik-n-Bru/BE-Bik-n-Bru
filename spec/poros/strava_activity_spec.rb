require "rails_helper"

RSpec.describe StravaActivity do 
  data = {calories: 453, distance: 23491082}
  let(:sa) { StravaActivity.new(data) }

  it "exists" do 
    expect(sa).to be_an_instance_of(StravaActivity)
  end

  it "has readable attributes" do 
    expect(sa.calories).to eq(453)
    expect(sa.distance_in_meters).to eq(23491082)
  end
end