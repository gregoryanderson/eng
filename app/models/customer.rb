class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name
  
  has_many :invoices
  has_many :transactions, through: :invoices
  
  def self.import(filename)
    CSV.foreach(filename, headers: true) do |row|
      first_name = row["first_name"]
      last_name = row["last_name"]
      id = row["id"]
      Customer.create(id: id, first_name: first_name, last_name: last_name)
    end
  end 

  def self.favorite_customer(merchant_id)
    select('customers.*, count(transactions.id) AS total_transactions')
      .joins(invoices: :transactions)
      .where(transactions: { result: 'success' } )
      .where(invoices: { merchant_id: merchant_id })
      .order('total_transactions DESC')
      .group(:id)
      .limit(1)
      .first
  end
end
