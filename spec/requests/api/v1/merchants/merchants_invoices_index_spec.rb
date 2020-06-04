require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  describe 'when I send a get request to the "merchant/:id/invoices" path' do
    before(:each) do
      @merchant_1 = Merchant.create(name: "Lucys", id: 1)
      @merchant_2 =  Merchant.create(name: "Gregs", id: 2)
      @customer = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
      @invoice_1 = Invoice.create(merchant_id: 1, customer_id: 1, id: 1, status: "shipped")
      @invoice_2 = Invoice.create(merchant_id: 1, customer_id: 1, id: 2, status: "shipped")
      @invoice_3 = Invoice.create(merchant_id: 1, customer_id: 1, id: 3, status: "shipped")
      @invoice_4 = Invoice.create(merchant_id: 2, customer_id: 1, id: 4, status: "shipped")
      @invoice_5 = Invoice.create(merchant_id: 2, customer_id: 1, id: 5, status: "shipped")

      @invoices = [@invoice_1, @invoice_2, @invoice_3]

      get "/api/v1/merchants/#{@merchant_1.id}/invoices"
      @hash = JSON.parse(response.body)
    end

    it 'I get a JSON:API response with all invoices associated with merchant' do
      expect(@hash.class).to eq(Hash)
      expect(@hash.keys).to eq(['data'])
      expect(@hash['data'].length).to eq(3)

      invoices = @hash['data']
      invoices.each_with_index do |invoice, index|
        expect(invoice['id']).to eq(@invoices[index].id.to_s)
        expect(invoice['type']).to eq('invoice')

        attributes = invoice['attributes']

        expect(attributes['id']).to eq(@invoices[index].id)
        expect(attributes['customer_id']).to eq(@invoices[index].customer_id)
        expect(attributes['status']).to eq(@invoices[index].status)
        expect(attributes['merchant_id']).to eq(@invoices[index].merchant_id)
      end
    end
  end
end