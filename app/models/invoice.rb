class Invoice < ApplicationRecord
  validates_presence_of :customer_id, :merchant_id, :status
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items

  def self.import(filepath)
    CSV.foreach(filepath, headers: true) do |row|
      customer_id = row["customer_id"]
      merchant_id = row["merchant_id"]
      status = row["status"]
      invoice = Invoice.new(customer_id: customer_id, 
                  merchant_id: merchant_id, 
                  status: status)
      if invoice.save
        invoice
      else 
        p invoice.errors.full_messages
      end
    end
  end 
end
