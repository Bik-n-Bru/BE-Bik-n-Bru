class User < ApplicationRecord
  has_many :activities
  has_many :badges
  validates :username, :token, :athlete_id, presence: true

  def create_badges
    earn_activity_badges
    earn_mileage_badges
    earn_brewery_badges
  end

  def earn_activity_badges
    activities_count = activities.count

    if activities_count == 1 
      badges.create(title: "Completed 1 Activity")
    elsif activities_count == 50
      badges.create(title: "Completed 50 Activities")
    elsif activities_count == 100
      badges.create(title: "Completed 100 Activities")
    end
  end

  def earn_mileage_badges
    total_distance = activities.sum(:distance)

    if badges.find_by(title: "Cycled 100 miles").nil? && total_distance >= 100
      badges.create(title: "Cycled 100 miles")
    elsif badges.find_by(title: "Cycled 500 miles").nil? && total_distance >= 500 
      badges.create(title: "Cycled 500 miles")
    elsif badges.find_by(title: "Cycled 1000 miles").nil? && total_distance >= 1000 
      badges.create(title: "Cycled 1000 miles")
    end
  end

  def earn_brewery_badges
    brewery_count = activities.select(:brewery_name).distinct.count

    if brewery_count % 10 == 0 
      badges.create(title: "Visited #{brewery_count} breweries")
    end
  end
end