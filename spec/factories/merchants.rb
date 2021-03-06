FactoryBot.define do
  factory :merchant do
    name { Faker::Name.name }
    created_at { Time.zone.parse(Faker::Date.unique.between(from: 10.years.ago, to: 1.year.ago).to_s) }
    updated_at { Time.zone.parse(Faker::Date.unique.between(from: 10.years.ago, to: 1.year.ago).to_s) }
  end
end