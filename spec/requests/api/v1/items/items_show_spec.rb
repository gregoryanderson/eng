require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Greg", id: 1)
    @item_1 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 1, merchant_id: 1)
    @item_2 = Item.create(name: "Thing Two", description: "Thing two is this thing", unit_price_in_cents: 12345, id: 2, merchant_id: 1)
  end

  describe 'when I send a request to the items show endpoint' do
    before(:each) do
      get "/api/v1/items/#{@item_1.id}"
      @json = JSON.parse(response.body)
    end

    it 'I get JSON data for a single item' do
      expect(@json.class).to eq(Hash)
      expect(@json.length).to eq(1)
      expect(@json['data'].length).to eq(3)

      expect(@json['data']['id']).to eq(@item_1.id.to_s)
      expect(@json['data']['type']).to eq('item')

      attributes = @json['data']['attributes']
      expect(attributes.length).to eq(5)

      expect(attributes['name']).to eq(@item_1.name)
      expect(attributes['id']).to eq(@item_1.id)
      expect(attributes['description']).to eq(@item_1.description)
      expect(attributes['unit_price']).to eq(sprintf('%.2f',
                                             @item_1.unit_price_in_cents / 100.0))
      expect(attributes['merchant_id']).to eq(@item_1.merchant_id)
    end
  end
end