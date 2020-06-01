class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :merchant_id

  attribute :unit_price do |object|
    sprintf('%.2f', object.unit_price_in_cents / 100.0)
  end
end
