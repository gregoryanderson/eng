require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Gregs", id: 1)
    @item_1 = Item.create(name: "Dog", description: "This is a Dog", id: 1, merchant_id: 1, unit_price_in_cents: 12345)
    @item_2 = Item.create(name: "Cat", description: "This is a Cat", id: 2, merchant_id: 1, unit_price_in_cents: 34512)
    @item_3 = Item.create(name: "Lala", description: "This is a Lala", id: 3, merchant_id: 1, unit_price_in_cents: 54321)
    @customer = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
    @invoice = Invoice.create(merchant_id: 1, customer_id: 1, id: 1, status: "shipped")
    @invoice_item_1 = InvoiceItem.create(item_id: 1, invoice_id: 1, id: 1, quantity: 1, unit_price_in_cents: 12345)
    @invoice_item_2 = InvoiceItem.create(item_id: 2, invoice_id: 1, id: 2, quantity: 1, unit_price_in_cents: 34512)
    @invoice_item_3 = InvoiceItem.create(item_id: 3, invoice_id: 1, id: 3, quantity: 1, unit_price_in_cents: 54321)
  end

  describe 'when I send a request to the invoices/:id/items path' do
    before(:each) do
      get "/api/v1/invoices/#{@invoice.id}/items"
      @json = JSON.parse(response.body)
    end

    it 'I get JSON data for all items associated with invoice' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].class).to eq(Array)
      expect(@json['data'].length).to eq(3)

      expected = [@item_1, @item_2, @item_3]
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