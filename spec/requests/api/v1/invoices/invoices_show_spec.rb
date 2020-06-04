require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @customer = Customer.create(first_name: "Greg", last_name: "Anderson", id: 1)
    @merchant = Merchant.create(name: "Alfred's", id: 1)
    @invoice = Invoice.create(customer_id: 1, merchant_id: 1, id: 1, status: 'shipped')
  end

  describe 'when I send a request to the invoices show endpoint' do
    before(:each) do
      get "/api/v1/invoices/#{@invoice.id}"
      @json = JSON.parse(response.body)
    end

    it 'I get JSON data for one invoice' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].length).to eq(3)

      invoice = @json['data']

      expect(invoice['id']).to eq(@invoice.id.to_s)
      expect(invoice['type']).to eq('invoice')

      attributes = invoice['attributes']

      expect(attributes['id']).to eq(@invoice.id)
      expect(attributes['customer_id']).to eq(@invoice.customer_id)
      expect(attributes['status']).to eq(@invoice.status)
      expect(attributes['merchant_id']).to eq(@invoice.merchant_id)
    end
  end
end