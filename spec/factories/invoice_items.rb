FactoryBot.define do
  factory :invoice_item do
    item
    invoice { nil }
    quantity { rand(1..10) }
    unit_price_in_cents { rand(100..50000) }
  end
end