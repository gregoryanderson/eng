require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Greg", id: 1)
    @item_1 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 1, merchant_id: 1)
    @item_2 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 2, merchant_id: 1)
    @item_3 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 3, merchant_id: 1)
    @customer = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
    @invoice = Invoice.create(merchant_id: 1, customer_id: 1, id: 1, status: "shipped")
    @invoice_item_1 = InvoiceItem.create(item_id: 1, invoice_id: 1, id: 1, quantity: 1, unit_price_in_cents: 12345)
    @invoice_item_2 = InvoiceItem.create(item_id: 2, invoice_id: 1, id: 2, quantity: 1, unit_price_in_cents: 12345)
    @invoice_item_3 = InvoiceItem.create(item_id: 3, invoice_id: 1, id: 3, quantity: 1, unit_price_in_cents: 12345)
  end

  describe 'when I send a request to the invoice_items show path' do
    before(:each) do
      get "/api/v1/invoice_items/#{@invoice_item_1.id}/"
      @json = JSON.parse(response.body)
    end

    it 'I get JSON data with attributes of invoice_item record' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].class).to eq(Hash)
      expect(@json['data'].length).to eq(3)

      expect(@json['data']['id']).to eq(@invoice_item_1.id.to_s)
      expect(@json['data']['type']).to eq('invoice_item')

      attributes = @json['data']['attributes']
      formatted_price = sprintf('%.2f', @invoice_item_1.unit_price_in_cents / 100.0)

      expect(attributes['id']).to eq(@invoice_item_1.id)
      expect(attributes['item_id']).to eq(@invoice_item_1.item_id)
      expect(attributes['invoice_id']).to eq(@invoice_item_1.invoice_id)
      expect(attributes['quantity']).to eq(@invoice_item_1.quantity)
      expect(attributes['unit_price']).to eq(formatted_price)
    end
  end
end