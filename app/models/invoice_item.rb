class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity, :unit_price_in_cents

  belongs_to :item
  belongs_to :invoice

  def self.import(filepath)
    CSV.foreach(filepath, headers: true) do |row|
      invoice_id = row["invoice_id"]
      item_id = row["item_id"]
      quantity = row["quantity"]
      unit_price_in_cents = row["unit_price"]
      invoice_item = InvoiceItem.new(invoice_id: invoice_id, 
                  item_id: item_id, 
                  quantity: quantity,
                  unit_price_in_cents: unit_price_in_cents)
      if invoice_item.save
        invoice_item
      else 
        p invoice_item.errors.full_messages
      end
    end
  end 
end
