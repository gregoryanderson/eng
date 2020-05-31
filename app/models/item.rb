class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price_in_cents, :merchant_id
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.import(filepath)
    CSV.foreach(filepath, headers: true) do |row|
      name = row["name"]
      description = row["description"]
      unit_price_in_cents = row["unit_price"]
      merchant_id = row["merchant_id"]
      item = Item.new(name: name, 
                  description: description, 
                  unit_price_in_cents: unit_price_in_cents, 
                  merchant_id: merchant_id)

      if item.save
        item
      else 
        byebug
        p item.errors.full_messages
      end
    end
  end 
end
