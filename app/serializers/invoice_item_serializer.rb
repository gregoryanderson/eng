class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :item_id, :invoice_id, :quantity
  
  attribute :unit_price do |object|
    sprintf('%.2f', object.unit_price_in_cents / 100.0)
  end
end
