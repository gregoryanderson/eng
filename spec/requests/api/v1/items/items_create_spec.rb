require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Alfred's", id: 1)
  end

  describe 'when I send a get request to the items new_item path' do
    before(:each) do
      post "/api/v1/items/new", params: { "name": "Buttermilk",
                                               "description": "A good doggy",
                                               "unit_price_in_cents": 54213, 
                                               "merchant_id": 1
                                              }
      @status_code = response.status
      @hash = JSON.parse(response.body)
      @new_item = Item.last
    end

    it 'an item is created in the database' do
      expect(@new_item.name).to eq("Buttermilk")
      expect(@new_item.description).to eq("A good doggy")
      expect(@new_item.unit_price_in_cents).to eq(54213)
      expect(@new_item.merchant_id).to eq(1)
    end

    it 'I receive a status code 201' do
      expect(@status_code).to eq(201)
    end

    skip 'and I receive a JSON:API response containing a unique id for that user' do
      expect(@response).to include(
        'data' => {
          'id' => @new_item.id.to_s
        }
      )
    end
  end
end