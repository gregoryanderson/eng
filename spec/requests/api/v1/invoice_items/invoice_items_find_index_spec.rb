require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Greg", id: 1)
    @item_1 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 1, merchant_id: 1)
    @item_2 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 2, merchant_id: 1)
    @item_3 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 3, merchant_id: 1)
    @item_4 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 4, merchant_id: 1)
    @item_5 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 5, merchant_id: 1)
    @item_6 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 6, merchant_id: 1)
    @customer = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
    @customer_2 = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 2)
    @invoice = Invoice.create(merchant_id: 1, customer_id: 1, id: 1, status: "shipped")
    @invoice_2 = Invoice.create(merchant_id: 1, customer_id: 2, id: 2, status: "shipped")
    @invoice_item_1 = InvoiceItem.create(item_id: 1, invoice_id: 1, id: 1, quantity: 1, unit_price_in_cents: 12345, updated_at: '2032-01-01') # unique ID, updated_at
    @invoice_item_2 = InvoiceItem.create(item_id: 2, invoice_id: 1, id: 2, unit_price_in_cents: 12345, quantity: 23) # unique quantity
    @invoice_item_3 = InvoiceItem.create(item_id: 3, invoice_id: 1, id: 3, quantity: 1, unit_price_in_cents: 60000) # unique unit_price
    @invoice_item_4 = InvoiceItem.create(item_id: 4, invoice_id: 1, id: 4, quantity: 1, unit_price_in_cents: 12345)
    @invoice_item_5 = InvoiceItem.create(item_id: 5, invoice_id: 1, id: 5, quantity: 1, unit_price_in_cents: 12345, created_at: '1234-12-23') # unique created_at
    @invoice_item_6 = InvoiceItem.create(item_id: 6, invoice_id: 2, id: 6, quantity: 1, unit_price_in_cents: 12345) # unique invoice_id
    @invoice_item_1a = InvoiceItem.create(item_id: 1, invoice_id: 1, id: 7, quantity: 1, unit_price_in_cents: 12345, updated_at: '2032-01-01') # unique updated_at
    @invoice_item_2a = InvoiceItem.create(item_id: 2, invoice_id: 1, id: 8, unit_price_in_cents: 12345, quantity: 23) # unique quantity
    @invoice_item_3a = InvoiceItem.create(item_id: 3, invoice_id: 1, id: 9, quantity: 1, unit_price_in_cents: 60000) # unique unit_price
    @invoice_item_4a = InvoiceItem.create(item_id: 4, invoice_id: 1, id: 10, quantity: 1, unit_price_in_cents: 12345) # unique item_id
    @invoice_item_5a = InvoiceItem.create(item_id: 5, invoice_id: 1, id: 11, quantity: 1, unit_price_in_cents: 12345, created_at: '1234-12-23') # unique created_at
    @invoice_item_6a = InvoiceItem.create(item_id: 1, invoice_id: 2, id: 12, quantity: 1, unit_price_in_cents: 12345) # unique invoice_id
  end

  describe 'when I send a get request to the invoice_items find_all path' do
    describe 'by its id attribute' do
      before(:each) do
        get "/api/v1/invoice_items/find_all?id=#{@invoice_item_1.id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of that invoice_item' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(1)

        expected = [@invoice_item_1]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('invoice_item')

          attributes = item['attributes']

          formatted_price = sprintf('%.2f', expected[index].unit_price_in_cents / 100.0)
          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['item_id']).to eq(expected[index].item_id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['quantity']).to eq(expected[index].quantity)
          expect(attributes['unit_price']).to eq(formatted_price)
        end
      end
    end

    describe 'by its quantity attribute' do
      before(:each) do
        get "/api/v1/invoice_items/find_all?quantity=#{@invoice_item_2.quantity}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of that invoice_item' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@invoice_item_2, @invoice_item_2a]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('invoice_item')

          attributes = item['attributes']

          formatted_price = sprintf('%.2f', expected[index].unit_price_in_cents / 100.0)
          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['item_id']).to eq(expected[index].item_id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['quantity']).to eq(expected[index].quantity)
          expect(attributes['unit_price']).to eq(formatted_price)
        end
      end
    end

    describe 'by its unit_price attribute' do
      before(:each) do
        formatted_price = sprintf('%.2f', @invoice_item_3.unit_price_in_cents / 100.0)
        get "/api/v1/invoice_items/find_all?unit_price_in_cents=#{formatted_price}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of that invoice_item' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@invoice_item_3, @invoice_item_3a]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('invoice_item')

          attributes = item['attributes']

          formatted_price = sprintf('%.2f', expected[index].unit_price_in_cents / 100.0)
          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['item_id']).to eq(expected[index].item_id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['quantity']).to eq(expected[index].quantity)
          expect(attributes['unit_price']).to eq(formatted_price)
        end
      end
    end

    describe 'by its updated_at attribute' do
      before(:each) do
        get "/api/v1/invoice_items/find_all?updated_at=#{@invoice_item_1.updated_at}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of that invoice_item' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@invoice_item_1, @invoice_item_1a]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('invoice_item')

          attributes = item['attributes']

          formatted_price = sprintf('%.2f', expected[index].unit_price_in_cents / 100.0)
          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['item_id']).to eq(expected[index].item_id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['quantity']).to eq(expected[index].quantity)
          expect(attributes['unit_price']).to eq(formatted_price)
        end
      end
    end

    describe 'by its created_at attribute' do
      before(:each) do
        get "/api/v1/invoice_items/find_all?created_at=#{@invoice_item_5.created_at}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of that invoice_item' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@invoice_item_5, @invoice_item_5a]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('invoice_item')

          attributes = item['attributes']

          formatted_price = sprintf('%.2f', expected[index].unit_price_in_cents / 100.0)
          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['item_id']).to eq(expected[index].item_id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['quantity']).to eq(expected[index].quantity)
          expect(attributes['unit_price']).to eq(formatted_price)
        end
      end
    end

    describe 'by its invoice_id attribute' do
      before(:each) do
        get "/api/v1/invoice_items/find_all?invoice_id=#{@invoice_item_6.invoice_id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of that invoice_item' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@invoice_item_6, @invoice_item_6a]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('invoice_item')

          attributes = item['attributes']

          formatted_price = sprintf('%.2f', expected[index].unit_price_in_cents / 100.0)
          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['item_id']).to eq(expected[index].item_id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['quantity']).to eq(expected[index].quantity)
          expect(attributes['unit_price']).to eq(formatted_price)
        end
      end
    end

    describe 'by its item_id attribute' do
      before(:each) do
        get "/api/v1/invoice_items/find_all?item_id=#{@invoice_item_4.item_id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of that invoice_item' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@invoice_item_4, @invoice_item_4a]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('invoice_item')

          attributes = item['attributes']

          formatted_price = sprintf('%.2f', expected[index].unit_price_in_cents / 100.0)
          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['item_id']).to eq(expected[index].item_id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['quantity']).to eq(expected[index].quantity)
          expect(attributes['unit_price']).to eq(formatted_price)
        end
      end
    end
  end
end