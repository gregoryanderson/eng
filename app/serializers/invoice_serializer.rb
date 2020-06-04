class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :merchant_id, :customer_id, :status

end
