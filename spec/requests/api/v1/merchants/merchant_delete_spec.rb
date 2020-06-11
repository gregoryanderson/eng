require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @customer = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
    @merchant = Merchant.create(name: "Gregs", id: 1)
    @merchant_2 = Merchant.create(name: "Lucys", id: 2)
    @item_1 = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 1, merchant_id: 1)
    @item_2 = Item.create(name: "Thing Two", description: "Thing two is this thing", unit_price_in_cents: 12345, id: 2, merchant_id: 2)
    @invoice_1 = Invoice.create(merchant_id: 1, customer_id: 1, id: 1, status: "shipped")
    @invoice_1 = Invoice.create(merchant_id: 2, customer_id: 1, id: 2, status: "shipped")
  end 

  describe 'when I send a get request to the merchants delete path' do
    before(:each) do
      delete "/api/v1/merchants/#{@merchant.id}/delete"
      @status_code = response.status
      # @hash = JSON.parse(response.body)
    end

    it 'a user is created in the database' do
      expect(Merchant.all.length).to eq(1)
      expect(Merchant.first.name).to eq("Lucys")
      expect(Invoice.all.length).to eq(1)
      expect(Item.all.length).to eq(1)
    end

    it 'I receive a status code 201' do
      expect(@status_code).to eq(204)
    end
  end
end