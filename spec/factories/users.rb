FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {Faker::Lorem.characters 6}
    confirmed_at {Date.today}

    trait :admin do
      admin {true}
    end
  end
end
