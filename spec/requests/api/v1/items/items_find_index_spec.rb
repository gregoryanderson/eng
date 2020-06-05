require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Greg", id: 1)
    @item_1 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 1, merchant_id: 1)
    @item_2 = Item.create( description: "Thing one is this thing", unit_price_in_cents: 12345, id: 2, merchant_id: 1, name: 'Test Item')
    @item_8 = Item.create(description: "Thing one is this thing", unit_price_in_cents: 12345, id: 8, merchant_id: 1, name: 'Test Item')
    @item_3 = Item.create(name: "Thing One", unit_price_in_cents: 12345, id: 3, merchant_id: 1, description: 'Bad Item')
    @item_9 = Item.create(name: "Thing One", unit_price_in_cents: 12345, id: 9, merchant_id: 1, description: 'Bad Item')
    @item_4 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 91919, id: 4, merchant_id: 1)
    @item_10 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 91919, id: 10, merchant_id: 1)
    @item_5 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 5, merchant_id: 1, created_at: '1985-10-22')
    @item_11 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 11, merchant_id: 1, created_at: '1985-10-22')
    @item_6 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 6, merchant_id: 1, updated_at: '2008-09-08')
    @item_12 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 12, merchant_id: 1, updated_at: '2008-09-08')
    @merchant_2 = Merchant.create(name: "Lucy", id: 2)
    @item_7 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 7, merchant_id: 2)
    @item_13 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 13, merchant_id: 2)
  end

  describe 'when I send a get request to the items find_all path' do
    describe 'by their name attribute case-insensitive' do
      before(:each) do
        get "/api/v1/items/find_all?name=#{@item_2.name.downcase}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of all found items' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@item_2, @item_8]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('item')

          attributes = item['attributes']
          formatted_price = sprintf('%.2f', expected[index].unit_price_in_cents / 100.0)

          expect(attributes['name']).to eq(expected[index].name)
          expect(attributes['description']).to eq(expected[index].description)
          expect(attributes['unit_price']).to eq(formatted_price)
          expect(attributes['merchant_id']).to eq(expected[index].merchant_id)
        end
      end
    end

    describe 'by their id attribute' do
      before(:each) do
        get "/api/v1/items/find_all?id=#{@item_1.id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of all found items' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(1)

        expected = [@item_1]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('item')

          attributes = item['attributes']
          formatted_price = sprintf('%.2f', expected[index].unit_price_in_cents / 100.0)

          expect(attributes['name']).to eq(expected[index].name)
          expect(attributes['description']).to eq(expected[index].description)
          expect(attributes['unit_price']).to eq(formatted_price)
          expect(attributes['merchant_id']).to eq(expected[index].merchant_id)
        end

      end
    end

    describe 'by their created_at attribute' do
      before(:each) do
        get "/api/v1/items/find_all?created_at=#{@item_5.created_at}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of all found items' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@item_5, @item_11]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('item')

          attributes = item['attributes']
          formatted_price = sprintf('%.2f', expected[index].unit_price_in_cents / 100.0)

          expect(attributes['name']).to eq(expected[index].name)
          expect(attributes['description']).to eq(expected[index].description)
          expect(attributes['unit_price']).to eq(formatted_price)
          expect(attributes['merchant_id']).to eq(expected[index].merchant_id)
        end

      end
    end

    describe 'by their updated_at attribute' do
      before(:each) do
        get "/api/v1/items/find_all?updated_at=#{@item_6.updated_at}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of all found items' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@item_6, @item_12]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('item')

          attributes = item['attributes']
          formatted_price = sprintf('%.2f', expected[index].unit_price_in_cents / 100.0)

          expect(attributes['name']).to eq(expected[index].name)
          expect(attributes['description']).to eq(expected[index].description)
          expect(attributes['unit_price']).to eq(formatted_price)
          expect(attributes['merchant_id']).to eq(expected[index].merchant_id)
        end

      end
    end

    describe 'by their description attribute' do
      before(:each) do
        get "/api/v1/items/find_all?description=#{@item_3.description}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of all found items' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@item_3, @item_9]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('item')

          attributes = item['attributes']
          formatted_price = sprintf('%.2f', expected[index].unit_price_in_cents / 100.0)

          expect(attributes['name']).to eq(expected[index].name)
          expect(attributes['description']).to eq(expected[index].description)
          expect(attributes['unit_price']).to eq(formatted_price)
          expect(attributes['merchant_id']).to eq(expected[index].merchant_id)
        end

      end
    end

    describe 'by their merchant_id attribute' do
      before(:each) do
        get "/api/v1/items/find_all?merchant_id=#{@item_7.merchant_id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of all found items' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@item_7, @item_13]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('item')

          attributes = item['attributes']
          formatted_price = sprintf('%.2f', expected[index].unit_price_in_cents / 100.0)

          expect(attributes['name']).to eq(expected[index].name)
          expect(attributes['description']).to eq(expected[index].description)
          expect(attributes['unit_price']).to eq(formatted_price)
          expect(attributes['merchant_id']).to eq(expected[index].merchant_id)
        end

      end
    end

    describe 'by their unit_price_in_cents attribute' do
      before(:each) do
        formatted_price = sprintf('%.2f', @item_4.unit_price_in_cents / 100.0)
        get "/api/v1/items/find_all?unit_price_in_cents=#{@item_4.unit_price_in_cents}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of all found items' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@item_4, @item_10]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('item')

          attributes = item['attributes']
          formatted_price = sprintf('%.2f', expected[index].unit_price_in_cents / 100.0)

          expect(attributes['name']).to eq(expected[index].name)
          expect(attributes['description']).to eq(expected[index].description)
          expect(attributes['unit_price']).to eq(formatted_price)
          expect(attributes['merchant_id']).to eq(expected[index].merchant_id)
        end
      end
    end
  end
end