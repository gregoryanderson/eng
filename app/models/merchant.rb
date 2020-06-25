require 'csv'

class Merchant < ApplicationRecord
  validates_presence_of :name
  
  has_many :items
  has_many :invoices

  def self.import(filepath)
    CSV.foreach(filepath, headers: true) do |row|
      name = row["name"]
      id = row["id"]
      Merchant.create(name: name, id: id)
    end
  end 

  def self.ci_name_find(name)
    where('LOWER(merchants.name) = LOWER(?)', name).first
  end

  def self.ci_name_find_all(name)
    where('LOWER(merchants.name) = LOWER(?)', name)
  end

  def self.most_revenue(quantity)
    scrubbed_quantity = [quantity.to_i, 0].max
    joins(invoices: [:transactions, :invoice_items])
      .where(transactions: { result: 'success' })
      .select('merchants.*,
              sum(invoice_items.quantity * invoice_items.unit_price_in_cents)
              AS total_revenue')
      .group(:id)
      .order('total_revenue DESC')
      .limit(scrubbed_quantity)
  end

  def self.favorite_merchant(customer_id)
    select('merchants.*, count(transactions.id) AS total_transactions')
      .joins(invoices: :transactions)
      .where(transactions: { result: 'success' } )
      .where(invoices: { customer_id: customer_id })
      .order('total_transactions DESC')
      .group(:id)
      .limit(1)
      .first
  end
end
