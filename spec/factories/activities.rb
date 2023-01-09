FactoryBot.define do
  factory :activity do
    user
    distance { Faker::Number.decimal(l_digits: 2) }
    num_drinks { (calories / 250).round }
    calories { 30 * distance }
    drink_type { Faker::Beer.name }
    brewery_name { Faker::Name.name }
    dollars_saved { ((distance / 22) * 3.5).round(2) }
    lbs_carbon_saved { (distance * 0.9).round(2) }
  end
end