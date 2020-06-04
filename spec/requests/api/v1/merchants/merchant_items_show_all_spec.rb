require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  describe 'when I send a get request to the "merchant/:id/items" path' do
    before(:each) do
      @merchant_1 = Merchant.create(name: "Lucy", id: 1)
      @merchant_2 = Merchant.create(name: "Greg", id: 2)
      @item_1 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 1, merchant_id: 1)
      @item_2 = Item.create(name: "Thing Two", description: "Thing two is this thing", unit_price_in_cents: 23456, id: 2, merchant_id: 1)
      @item_3 = Item.create(name: "Thing Three", description: "Thing three is this thing", unit_price_in_cents: 34567, id: 3, merchant_id: 1)
      @item_4 = Item.create(name: "Thing Four", description: "Thing four is this thing", unit_price_in_cents: 45678, id: 4, merchant_id: 2)
      @item_5 = Item.create(name: "Thing Five", description: "Thing five is this thing", unit_price_in_cents: 56789, id: 5, merchant_id: 2)

      @items = [@item_1, @item_2, @item_3]
      get "/api/v1/merchants/#{@merchant_1.id}/items"
      @hash = JSON.parse(response.body)
    end

    it 'I get a JSON:API response with all items associated with merchant' do
      expect(@hash.class).to eq(Hash)
      expect(@hash.keys).to eq(['data'])
      expect(@hash['data'].length).to eq(3)

      items = @hash['data']
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