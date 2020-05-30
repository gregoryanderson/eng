class Merchant < ApplicationRecord
  validates_presence_of :name

  def self.import(filepath)
    CSV.foreach(filepath, headers: true) do |row|
      name = row["name"]
      Merchant.create(name: name)
    end
  end 
end
