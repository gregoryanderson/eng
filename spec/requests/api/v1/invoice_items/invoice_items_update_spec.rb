require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Gregs", id: 1)
    @customer = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
    @item_1 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 1, merchant_id: 1)
    @item_2 = Item.create(name: "Thing Two", description: "Thing two is this thing", unit_price_in_cents: 12345, id: 2, merchant_id: 1)
    @invoice_1 = Invoice.create(merchant_id: 1, customer_id: 1, id: 1, status: "shipped")
    @invoice_2 = Invoice.create(merchant_id: 1, customer_id: 1, id: 2, status: "shipped")
    @invoice_item_1 = InvoiceItem.create(item_id: 1, invoice_id: 1, id: 1, quantity: 1, unit_price_in_cents: 12345)
  end 

  describe 'when I send a get request to the items update path' do
    before(:each) do
      post "/api/v1/invoice_items/#{@invoice_item_1.id}/update", 
              params: { item_id: 2, 
                        invoice_id: 2, 
                        quantity: 5, 
                        unit_price_in_cents: 22222}
      @status_code = response.status
    end

    it 'an item is updated in the database' do
      expect(InvoiceItem.first.item_id).to eq(2)
      expect(InvoiceItem.first.invoice_id).to eq(2)
      expect(InvoiceItem.first.unit_price_in_cents).to eq(22222)
      expect(InvoiceItem.first.quantity).to eq(5)
    end

    it 'I receive a status code 200' do
      expect(@status_code).to eq(200)
    end
  end
end