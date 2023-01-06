FactoryBot.define do
  factory :activity do
    user
    brewery_name { Faker::Number.number(digits: 6) }
    distance { Faker::Number.decimal(l_digits: 2) }
    num_drinks { Faker::Number.number(digits: 1) }
    calories { Faker::Number.number(digits: 3) }
    drink_type { Faker::Beer.name }
    brewery_name { Faker::Name.name }
  end
end