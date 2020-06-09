require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @customer1 = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
    @customer2 = Customer.create(first_name: "Dara", last_name: "Conklin", id: 2)
  end 

  describe 'when I send a get request to the customers delete path' do
    before(:each) do
      delete "/api/v1/customers/#{@customer1.id}/delete"
      @status_code = response.status
      # @hash = JSON.parse(response.body)
    end

    it 'a user is created in the database' do
      expect(Customer.all.length).to eq(1)
      expect(Customer.first.first_name).to eq("Dara")
    end

    it 'I receive a status code 201' do
      expect(@status_code).to eq(204)
    end
  end
end