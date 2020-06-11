FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    created_at { Time.zone.parse(Faker::Date.unique.between(from: 10.years.ago, to: 1.year.ago).to_s) }
    updated_at { Time.zone.parse(Faker::Date.unique.between(from: 10.years.ago, to: 1.year.ago).to_s) }
  end
end