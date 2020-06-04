require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @customer_1 = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
    @customer_2 = Customer.create(first_name: "Bobby", last_name: "Thompson", id: 2)
    @merchant_1 = Merchant.create(name: "Gregs", id: 1)
    @merchant_2 = Merchant.create(name: "Als", id: 2)
    @merchant_3 = Merchant.create(name: "Bettys", id: 3)
    @invoice_1 = Invoice.create(merchant_id: 1, customer_id: 1, id: 1, status: "shipped")
    @invoice_2 = Invoice.create(merchant_id: 2, customer_id: 1, id: 2, status: "shipped", updated_at: '2020-01-01')
    @invoice_3 = Invoice.create(merchant_id: 3, customer_id: 1, id: 3, status: "shipped", created_at: '2020-02-01')
    @invoice_4 = Invoice.create(merchant_id: 1, customer_id: 2, id: 4, status: 'borked')
  end

  describe 'when I send a get request to the invoices find path' do
    describe 'by its id attribute case-insensitive' do
      before(:each) do
        get "/api/v1/invoices/find?id=#{@invoice_1.id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].length).to eq(3)

        expect(@json['data']['id']).to eq(@invoice_1.id.to_s)
        expect(@json['data']['type']).to eq('invoice')

        attributes = @json['data']['attributes']

        expect(attributes['id']).to eq(@invoice_1.id)
        expect(attributes['customer_id']).to eq(@invoice_1.customer_id)
        expect(attributes['status']).to eq(@invoice_1.status)
        expect(attributes['merchant_id']).to eq(@invoice_1.merchant_id)
      end
    end

    describe 'by its (case-insensitive) status attribute' do
      before(:each) do
        get "/api/v1/invoices/find?status=#{@invoice_4.status.upcase}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].length).to eq(3)

        expect(@json['data']['id']).to eq(@invoice_4.id.to_s)
        expect(@json['data']['type']).to eq('invoice')

        attributes = @json['data']['attributes']

        expect(attributes['id']).to eq(@invoice_4.id)
        expect(attributes['customer_id']).to eq(@invoice_4.customer_id)
        expect(attributes['status']).to eq(@invoice_4.status)
        expect(attributes['merchant_id']).to eq(@invoice_4.merchant_id)
      end
    end

    describe 'by its created_at attribute' do
      before(:each) do
        get "/api/v1/invoices/find?created_at=#{@invoice_3.created_at}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].length).to eq(3)

        expect(@json['data']['id']).to eq(@invoice_3.id.to_s)
        expect(@json['data']['type']).to eq('invoice')

        attributes = @json['data']['attributes']

        expect(attributes['id']).to eq(@invoice_3.id)
        expect(attributes['customer_id']).to eq(@invoice_3.customer_id)
        expect(attributes['status']).to eq(@invoice_3.status)
        expect(attributes['merchant_id']).to eq(@invoice_3.merchant_id)
      end
    end

    describe 'by its updated_at attribute' do
      before(:each) do
        get "/api/v1/invoices/find?updated_at=#{@invoice_2.updated_at}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].length).to eq(3)

        expect(@json['data']['id']).to eq(@invoice_2.id.to_s)
        expect(@json['data']['type']).to eq('invoice')

        attributes = @json['data']['attributes']

        expect(attributes['id']).to eq(@invoice_2.id)
        expect(attributes['customer_id']).to eq(@invoice_2.customer_id)
        expect(attributes['status']).to eq(@invoice_2.status)
        expect(attributes['merchant_id']).to eq(@invoice_2.merchant_id)
      end
    end

    describe 'by its merchant_id attribute' do
      before(:each) do
        get "/api/v1/invoices/find?merchant_id=#{@invoice_3.merchant_id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].length).to eq(3)

        expect(@json['data']['id']).to eq(@invoice_3.id.to_s)
        expect(@json['data']['type']).to eq('invoice')

        attributes = @json['data']['attributes']

        expect(attributes['id']).to eq(@invoice_3.id)
        expect(attributes['customer_id']).to eq(@invoice_3.customer_id)
        expect(attributes['status']).to eq(@invoice_3.status)
        expect(attributes['merchant_id']).to eq(@invoice_3.merchant_id)
      end
    end

    describe 'by its customer_id attribute' do
      before(:each) do
        get "/api/v1/invoices/find?customer_id=#{@invoice_4.customer_id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].length).to eq(3)

        expect(@json['data']['id']).to eq(@invoice_4.id.to_s)
        expect(@json['data']['type']).to eq('invoice')

        attributes = @json['data']['attributes']

        expect(attributes['id']).to eq(@invoice_4.id)
        expect(attributes['customer_id']).to eq(@invoice_4.customer_id)
        expect(attributes['status']).to eq(@invoice_4.status)
        expect(attributes['merchant_id']).to eq(@invoice_4.merchant_id)
      end
    end
  end
end