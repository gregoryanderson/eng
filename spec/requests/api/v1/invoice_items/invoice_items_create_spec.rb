require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Greg", id: 1)
    @customer = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
    @invoice = Invoice.create(merchant_id: 1, customer_id: 1, id: 1, status: "shipped")
    @item = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 1, merchant_id: 1)

    @invoice_item_3 = InvoiceItem.create(item_id: 3, invoice_id: 1, id: 3, quantity: 1, unit_price_in_cents: 12345)
  end

  describe 'when I send a post request to the invoice_items new path' do
    before(:each) do
      post "/api/v1/invoice_items/new", params: { "item_id": 1,
                                                  "invoice_id": 1,
                                                  "quantity": 5,
                                                  "unit_price_in_cents": 33333
                                                }
      @status_code = response.status
      @hash = JSON.parse(response.body)
      @new_invoice_item = InvoiceItem.last
    end

    it 'an invoice_item is created in the database' do
      expect(@new_invoice_item.item_id).to eq(1)
      expect(@new_invoice_item.invoice_id).to eq(1)
      expect(@new_invoice_item.quantity).to eq(5)
      expect(@new_invoice_item.unit_price_in_cents).to eq(33333)
    end

    it 'I receive a status code 201' do
      expect(@status_code).to eq(201)
    end

    skip 'and I receive a JSON:API response containing a unique id for that user' do
      expect(@response).to include(
        'data' => {
          'id' => @new_customer.id.to_s
        }
      )
    end
  end
end