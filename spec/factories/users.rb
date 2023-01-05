FactoryBot.define do
  factory :user do
    athlete_id { Faker::Number.number(digits: 6) }
    username { Faker::Fantasy::Tolkien.character }
    token { Faker::Number.number(digits: 10) }
    city {Faker::Address.city}
    state {Faker::Address.state}
  end
end