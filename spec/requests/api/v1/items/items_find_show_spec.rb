require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Greg", id: 1)
    @item_1 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 1, merchant_id: 1)
    @item_2 = Item.create(description: "Thing one is this thing", unit_price_in_cents: 12345, id: 2, merchant_id: 1, name: 'Test Item')
    @item_3 = Item.create(name: "Thing One", unit_price_in_cents: 12345, id: 3, merchant_id: 1, description: 'Bad Item')
    @item_4 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 91919, id: 4, merchant_id: 1)
    @item_5 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 5, merchant_id: 1, created_at: '1985-10-22')
    @item_6 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 6, merchant_id: 1, updated_at: '2008-09-08')
    @merchant_2 = Merchant.create(name: "Lucy", id: 2)
    @item_7 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 7, merchant_id: 2)
  end

  describe 'when I send a get request to the items find path' do
    describe 'by its name attribute case-insensitive' do
      before(:each) do
        get "/api/v1/items/find?name=#{@item_2.name.downcase}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that item' do
        expect(@json.class).to eq(Hash)
        expect(@json.length).to eq(1)
        expect(@json['data'].length).to eq(3)

        expect(@json['data']['id']).to eq(@item_2.id.to_s)
        expect(@json['data']['type']).to eq('item')

        attributes = @json['data']['attributes']
        expect(attributes.length).to eq(5)

        expect(attributes['name']).to eq(@item_2.name)
        expect(attributes['id']).to eq(@item_2.id)
        expect(attributes['description']).to eq(@item_2.description)
        expect(attributes['unit_price']).to eq(sprintf('%.2f',
                                               @item_2.unit_price_in_cents / 100.0))
        expect(attributes['merchant_id']).to eq(@item_2.merchant_id)
      end
    end

    describe 'by its id attribute' do
      before(:each) do
        get "/api/v1/items/find?id=#{@item_1.id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that item' do
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

    describe 'by its created_at attribute' do
      before(:each) do
        get "/api/v1/items/find?created_at=#{@item_5.created_at}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that item' do
        expect(@json.class).to eq(Hash)
        expect(@json.length).to eq(1)
        expect(@json['data'].length).to eq(3)

        expect(@json['data']['id']).to eq(@item_5.id.to_s)
        expect(@json['data']['type']).to eq('item')

        attributes = @json['data']['attributes']
        expect(attributes.length).to eq(5)

        expect(attributes['name']).to eq(@item_5.name)
        expect(attributes['id']).to eq(@item_5.id)
        expect(attributes['description']).to eq(@item_5.description)
        expect(attributes['unit_price']).to eq(sprintf('%.2f',
                                               @item_5.unit_price_in_cents / 100.0))
        expect(attributes['merchant_id']).to eq(@item_5.merchant_id)
      end
    end

    describe 'by its updated_at attribute' do
      before(:each) do
        get "/api/v1/items/find?updated_at=#{@item_6.updated_at}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that item' do
        expect(@json.class).to eq(Hash)
        expect(@json.length).to eq(1)
        expect(@json['data'].length).to eq(3)

        expect(@json['data']['id']).to eq(@item_6.id.to_s)
        expect(@json['data']['type']).to eq('item')

        attributes = @json['data']['attributes']
        expect(attributes.length).to eq(5)

        expect(attributes['name']).to eq(@item_6.name)
        expect(attributes['id']).to eq(@item_6.id)
        expect(attributes['description']).to eq(@item_6.description)
        expect(attributes['unit_price']).to eq(sprintf('%.2f',
                                               @item_6.unit_price_in_cents / 100.0))
        expect(attributes['merchant_id']).to eq(@item_6.merchant_id)
      end
    end

    describe 'by its description attribute' do
      before(:each) do
        get "/api/v1/items/find?description=#{@item_3.description}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that item' do
        expect(@json.class).to eq(Hash)
        expect(@json.length).to eq(1)
        expect(@json['data'].length).to eq(3)

        expect(@json['data']['id']).to eq(@item_3.id.to_s)
        expect(@json['data']['type']).to eq('item')

        attributes = @json['data']['attributes']
        expect(attributes.length).to eq(5)

        expect(attributes['name']).to eq(@item_3.name)
        expect(attributes['id']).to eq(@item_3.id)
        expect(attributes['description']).to eq(@item_3.description)
        expect(attributes['unit_price']).to eq(sprintf('%.2f',
                                               @item_3.unit_price_in_cents / 100.0))
        expect(attributes['merchant_id']).to eq(@item_3.merchant_id)
      end
    end

    describe 'by its merchant_id attribute' do
      before(:each) do
        get "/api/v1/items/find?merchant_id=#{@item_7.merchant_id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that item' do
        expect(@json.class).to eq(Hash)
        expect(@json.length).to eq(1)
        expect(@json['data'].length).to eq(3)

        expect(@json['data']['id']).to eq(@item_7.id.to_s)
        expect(@json['data']['type']).to eq('item')

        attributes = @json['data']['attributes']
        expect(attributes.length).to eq(5)

        expect(attributes['name']).to eq(@item_7.name)
        expect(attributes['id']).to eq(@item_7.id)
        expect(attributes['description']).to eq(@item_7.description)
        expect(attributes['unit_price']).to eq(sprintf('%.2f',
                                               @item_7.unit_price_in_cents / 100.0))
        expect(attributes['merchant_id']).to eq(@item_7.merchant_id)
      end
    end

    describe 'by its unit_price attribute' do
      before(:each) do
        get "/api/v1/items/find?unit_price_in_cents=#{@item_4.unit_price_in_cents}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that item' do
        expect(@json.class).to eq(Hash)
        expect(@json.length).to eq(1)
        expect(@json['data'].length).to eq(3)

        expect(@json['data']['id']).to eq(@item_4.id.to_s)
        expect(@json['data']['type']).to eq('item')

        attributes = @json['data']['attributes']
        expect(attributes.length).to eq(5)

        expect(attributes['name']).to eq(@item_4.name)
        expect(attributes['id']).to eq(@item_4.id)
        expect(attributes['description']).to eq(@item_4.description)
        expect(attributes['unit_price']).to eq(sprintf('%.2f',
                                               @item_4.unit_price_in_cents / 100.0))
        expect(attributes['merchant_id']).to eq(@item_4.merchant_id)
      end
    end
  end
end