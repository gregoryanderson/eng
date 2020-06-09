require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  describe 'when I send a get request to the customers show path' do
    before(:each) do
      post "/api/v1/customers/new_customer", params: { "first_name": "Buttermilk",
                                                       "last_name": "Anderconk"}
      @status_code = response.status
      @hash = JSON.parse(response.body)
      @new_customer = Customer.last
    end

    it 'a user is created in the database' do
      expect(@new_customer.first_name).to eq("Buttermilk")
    end

    it 'I receive a status code 201' do
      expect(@status_code).to eq(201)
    end

    skip 'and I receive a JSON:API response containing a unique id for that user' do
      expect(@response).to include(
        'data' => {
          'id' => @new_customer.id.to_s
        }
      )
    end
  end
end