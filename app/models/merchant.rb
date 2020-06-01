class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items

  def self.import(filepath)
    CSV.foreach(filepath, headers: true) do |row|
      name = row["name"]
      id = row["id"]
      Merchant.create(name: name, id: id)
    end
  end 
end
