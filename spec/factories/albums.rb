FactoryBot.define do
  factory :album do
    name {Faker::Music.album}
    year {Time.now.year.to_s}
  end
end
