require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @customer = Customer.create(first_name: "Greg", last_name: "Anderson", id: 1)
    @merchant_1 = Merchant.create(name: "Alfred's", id: 1)
    @merchant_2 = Merchant.create(name: "Bob's", id: 2)
    @merchant_3 = Merchant.create(name: "Cici's", id: 3)
    @invoice_1 = Invoice.create(customer_id: 1, merchant_id: 1, id: 1, status: 'shipped')
    @invoice_2 = Invoice.create(customer_id: 1, merchant_id: 2, id: 2, status: 'shipped')
    @invoice_3 = Invoice.create(customer_id: 1, merchant_id: 3, id: 3, status: 'shipped')
    @invoices = [@invoice_1, @invoice_2, @invoice_3]
  end

  describe 'when I send a request to the invoices index endpoint' do
    before(:each) do
      get "/api/v1/invoices/"
      @json = JSON.parse(response.body)
    end

    it 'I get JSON data for all invoices' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].length).to eq(3)

      invoices = @json['data']
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