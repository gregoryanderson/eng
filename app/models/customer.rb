class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  def self.import(filename)
    CSV.foreach(filename, headers: true) do |row|
      first_name = row["first_name"]
      last_name = row["last_name"]
      Customer.create(first_name: first_name, last_name: last_name)
    end
  end 


end
