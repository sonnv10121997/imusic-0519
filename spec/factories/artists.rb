FactoryBot.define do
  factory :artist do
    name {Faker::Artist.name}
    description {Faker::Lorem.paragraphs}
    dob {Date.today}
    country {Faker::Nation.nationality}
  end
end
