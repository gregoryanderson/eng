require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Greg", id: 1)
    @customer = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
    @invoice = Invoice.create(merchant_id: 1, customer_id: 1, id: 1, status: "shipped")
    @item = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 1, merchant_id: 1)
    @invoice_item = InvoiceItem.create(item_id: 1, invoice_id: 1, id: 1, quantity: 1, unit_price_in_cents: 12345) 
  end

  describe 'when I send a request to the invoice_item-item endpoint' do
    before(:each) do
      get "/api/v1/invoice_items/#{@invoice_item.id}/item"
      @json = JSON.parse(response.body)
    end

    it 'I get JSON data for the item associated with invoice_item' do
      expect(@json.class).to eq(Hash)
      expect(@json.length).to eq(1)
      expect(@json['data'].length).to eq(3)

      expect(@json['data']['id']).to eq(@item.id.to_s)
      expect(@json['data']['type']).to eq('item')

      attributes = @json['data']['attributes']
      expect(attributes.length).to eq(5)

      expect(attributes['name']).to eq(@item.name)
      expect(attributes['id']).to eq(@item.id)
      expect(attributes['description']).to eq(@item.description)
      expect(attributes['unit_price']).to eq(sprintf('%.2f',
                                             @item.unit_price_in_cents / 100.0))
      expect(attributes['merchant_id']).to eq(@item.merchant_id)
    end
  end
end