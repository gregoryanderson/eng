require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Gregs", id: 1)
    @customer = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
    @item_1 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 1, merchant_id: 1)
    @item_2 = Item.create(name: "Thing Two", description: "Thing two is this thing", unit_price_in_cents: 12345, id: 2, merchant_id: 1)
    @invoice = Invoice.create(merchant_id: 1, customer_id: 1, id: 1, status: "shipped")
    @invoice_item_1 = InvoiceItem.create(item_id: 1, invoice_id: 1, id: 1, quantity: 1, unit_price_in_cents: 12345)
    @invoice_item_2 = InvoiceItem.create(item_id: 2, invoice_id: 1, id: 2, unit_price_in_cents: 12345, quantity: 23)
  end 

  describe 'when I send a delete request to the items delete path' do
    before(:each) do
      delete "/api/v1/invoice_items/#{@invoice_item_1.id}/delete"
      @status_code = response.status
    end

    it 'an invoice_item is deleted in the database' do
      expect(InvoiceItem.all.length).to eq(1)
      expect(InvoiceItem.first.quantity).to eq(23)
    end

    it 'I receive a status code 204' do
      expect(@status_code).to eq(204)
    end
  end
end