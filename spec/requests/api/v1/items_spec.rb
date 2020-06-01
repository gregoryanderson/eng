require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Greg", id: 1)
    @item1 = Item.create(name:"a", description: "aaa", unit_price_in_cents: 12345, merchant_id: @merchant.id, id: 1)
    @item2 = Item.create(name:"b", description: "bbb", unit_price_in_cents: 54321, merchant_id: @merchant.id, id: 2)
    @item3 = Item.create(name:"c", description: "ccc", unit_price_in_cents: 34512, merchant_id: @merchant.id, id: 3)

    @items = [@item1, @item2, @item3]
  end

  describe 'when I send a request to the items index endpoint' do
    before(:each) do
      get "/api/v1/items/"
      @json = JSON.parse(response.body)
    end

    it 'I get JSON data for all items' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].length).to eq(3)

      items = @json['data']
      items.each_with_index do |item, index|
        expect(item['id']).to eq(@items[index].id.to_s)
        expect(item['type']).to eq('item')

        attributes = item['attributes']

        expect(attributes['name']).to eq(@items[index].name)
        expect(attributes['description']).to eq(@items[index].description)
        expect(attributes['unit_price']).to eq(sprintf('%.2f',
                                              @items[index].unit_price_in_cents / 100.0))
        expect(attributes['merchant_id']).to eq(@items[index].merchant_id)
      end
    end
  end
end