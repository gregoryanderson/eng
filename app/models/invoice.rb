require 'csv'

class Invoice < ApplicationRecord
  
  validates_presence_of :customer_id, :merchant_id, :status

  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items

  def self.total_revenue_on_date(date)
    total_revenue = joins(:invoice_items, :transactions)
      .where(created_at: (date + ' 00:00:00')..(date + ' 23:59:59'))
      .where(transactions: { result: 'success' })
      .sum('invoice_items.quantity * invoice_items.unit_price_in_cents')
    total_revenue / 100.0
  end

  def self.import(filepath)
    CSV.foreach(filepath, headers: true) do |row|
      customer_id = row["customer_id"]
      merchant_id = row["merchant_id"]
      status = row["status"]
      id = row["id"]
      invoice = Invoice.new(customer_id: customer_id, 
                  merchant_id: merchant_id, 
                  status: status,
                  id: id)
      if invoice.save
        invoice
      else 
        p invoice.errors.full_messages
      end
    end
  end 
end
