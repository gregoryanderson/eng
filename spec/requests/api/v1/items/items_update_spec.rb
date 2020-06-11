require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Greg", id: 1)
    @merchant = Merchant.create(name: "Lucy", id: 2)
    @item_1 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 1, merchant_id: 1)
  end 

  describe 'when I send a get request to the items update path' do
    before(:each) do
      post "/api/v1/items/#{@item_1.id}/update", params: {name:"Greg", description: "Good stuff", unit_price_in_cents: 54321, merchant_id: 2}
      @status_code = response.status
    end

    it 'an item is updated in the database' do
      expect(Item.first.name).to eq("Greg")
      expect(Item.first.description).to eq("Good stuff")
      expect(Item.first.unit_price_in_cents).to eq(54321)
      expect(Item.first.merchant_id).to eq(2)
    end

    it 'I receive a status code 200' do
      expect(@status_code).to eq(200)
    end
  end
end