require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  describe 'when I send a get request to the merchants post path' do
    before(:each) do
      post "/api/v1/merchants/new_merchant", params: { "name": "Buttermilk"}
      @status_code = response.status
      @hash = JSON.parse(response.body)
      @new_merchant = Merchant.last
    end

    it 'a merchant is created in the database' do
      expect(@new_merchant.name).to eq("Buttermilk")
    end

    it 'I receive a status code 201' do
      expect(@status_code).to eq(201)
    end

    skip 'and I receive a JSON:API response with a unique id for that merchant' do
      expect(@response).to include(
        'data' => {
          'id' => @new_customer.id.to_s
        }
      )
    end
  end
end