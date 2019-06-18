FactoryBot.define do
  factory :track do
    title {Faker::Lorem.characters 10}
    year {Time.now.year}
  end
end
