require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @customer_1 = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
  end 

  describe 'when I send a get request to the customers update path' do
    before(:each) do
      post "/api/v1/customers/#{@customer_1.id}/update", params: {first_name:"Greg", last_name: "Anderson"}
      @status_code = response.status
    end

    it 'a user is updated in the database' do
      expect(Customer.first.first_name).to eq("Greg")
      expect(Customer.first.last_name).to eq("Anderson")
    end

    it 'I receive a status code 200' do
      expect(@status_code).to eq(200)
    end
  end
end