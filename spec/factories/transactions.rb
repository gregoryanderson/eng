
FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { Faker::Finance.credit_card(:visa).delete('-') }
    credit_card_expiration_date { nil }
    result { 'success' }
  end
end