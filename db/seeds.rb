# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
 
20.times do 
  FactoryBot.create(:user) do |user|
    FactoryBot.create_list(:activity, 50, user: user)
  end
end

amanda = FactoryBot.create(:user, athlete_id: 111365515)
FactoryBot.create_list(:activity, 50, user: amanda)