FactoryBot.define do
  factory :activity do
    user
    distance { Faker::Number.decimal(l_digits: 2) }
    num_drinks { Faker::Number.number(digits: 1) }
    calories { Faker::Number.number(digits: 3) }
    drink_type { Faker::Beer.name }
    brewery_name { Faker::Name.name }
    dollars_saved { Faker::Number.decimal(l_digits: 2) }
    lbs_carbon_saved { Faker::Number.number(digits: 2) }
  end
end