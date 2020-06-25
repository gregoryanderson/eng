require 'csv'

class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number, :result

  belongs_to :invoice

  def self.import(filepath)
    CSV.foreach(filepath, headers: true) do |row|
      credit_card_number = row["credit_card_number"]
      credit_card_expiration_date = row["credit_card_expiration_date"]
      result = row["result"]
      id = row["id"]
      invoice_id = row["invoice_id"]
      Transaction.create(credit_card_number: credit_card_number, 
                        credit_card_expiration_date: credit_card_expiration_date, 
                        result: result,
                        id: id,
                        invoice_id: invoice_id)
    end
  end 
end
