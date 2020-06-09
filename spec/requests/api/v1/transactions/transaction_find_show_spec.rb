require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Greg", id: 1)
    @customer = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
    @invoice = Invoice.create(merchant_id: 1, customer_id: 1, id: 1, status: "shipped")
    @invoice_2 = Invoice.create(merchant_id: 1, customer_id: 1, id: 2, status: "shipped")
    @transaction_1 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 1, invoice_id: 1) # unique id, first 'success'
    @transaction_2 = Transaction.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2020', result: "charged", id: 2, invoice_id: 1) # unique cc#
    @transaction_3 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 3, invoice_id: 1, created_at: '2020-02-02') # unique created_at
    @transaction_4 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 4, invoice_id: 1, updated_at: '1985-10-22') # unique updated_at
    @transaction_5 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', id: 5, invoice_id: 1, result: 'borked') # unique result
    @transaction_7 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 7, invoice_id: 2) # unique invoice_id
  end

  describe 'when I send a get request to the transactions find path' do
    describe 'by its id attribute' do
      before(:each) do
        get "/api/v1/transactions/find?id=#{@transaction_1.id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].length).to eq(3)

        expect(@json['data']['id']).to eq(@transaction_1.id.to_s)
        expect(@json['data']['type']).to eq('transaction')

        attributes = @json['data']['attributes']

        expect(attributes['id']).to eq(@transaction_1.id)
        expect(attributes['invoice_id']).to eq(@transaction_1.invoice_id)
        expect(attributes['result']).to eq(@transaction_1.result)
        expect(attributes['credit_card_number']).to eq(@transaction_1.credit_card_number)

      end
    end

    describe 'by its (case-insensitive) result attribute' do
      before(:each) do
        get "/api/v1/transactions/find?result=#{@transaction_5.result.upcase}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].length).to eq(3)

        expect(@json['data']['id']).to eq(@transaction_5.id.to_s)
        expect(@json['data']['type']).to eq('transaction')

        attributes = @json['data']['attributes']

        expect(attributes['id']).to eq(@transaction_5.id)
        expect(attributes['invoice_id']).to eq(@transaction_5.invoice_id)
        expect(attributes['result']).to eq(@transaction_5.result)
        expect(attributes['credit_card_number']).to eq(@transaction_5.credit_card_number)
      end
    end

    describe 'by its created_at attribute' do
      before(:each) do
        get "/api/v1/transactions/find?created_at=#{@transaction_3.created_at}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].length).to eq(3)

        expect(@json['data']['id']).to eq(@transaction_3.id.to_s)
        expect(@json['data']['type']).to eq('transaction')

        attributes = @json['data']['attributes']

        expect(attributes['id']).to eq(@transaction_3.id)
        expect(attributes['invoice_id']).to eq(@transaction_3.invoice_id)
        expect(attributes['result']).to eq(@transaction_3.result)
        expect(attributes['credit_card_number']).to eq(@transaction_3.credit_card_number)
      end
    end

    describe 'by its updated_at attribute' do
      before(:each) do
        get "/api/v1/transactions/find?updated_at=#{@transaction_4.updated_at}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].length).to eq(3)

        expect(@json['data']['id']).to eq(@transaction_4.id.to_s)
        expect(@json['data']['type']).to eq('transaction')

        attributes = @json['data']['attributes']

        expect(attributes['id']).to eq(@transaction_4.id)
        expect(attributes['invoice_id']).to eq(@transaction_4.invoice_id)
        expect(attributes['result']).to eq(@transaction_4.result)
        expect(attributes['credit_card_number']).to eq(@transaction_4.credit_card_number)
      end
    end

    describe 'by its invoice_id attribute' do
      before(:each) do
        get "/api/v1/transactions/find?invoice_id=#{@transaction_7.invoice_id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].length).to eq(3)

        expect(@json['data']['id']).to eq(@transaction_7.id.to_s)
        expect(@json['data']['type']).to eq('transaction')

        attributes = @json['data']['attributes']

        expect(attributes['id']).to eq(@transaction_7.id)
        expect(attributes['invoice_id']).to eq(@transaction_7.invoice_id)
        expect(attributes['result']).to eq(@transaction_7.result)
        expect(attributes['credit_card_number']).to eq(@transaction_7.credit_card_number)
      end
    end

    describe 'by its credit_card_number attribute' do
      before(:each) do
        get "/api/v1/transactions/find?credit_card_number=#{@transaction_2.credit_card_number}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].length).to eq(3)

        expect(@json['data']['id']).to eq(@transaction_2.id.to_s)
        expect(@json['data']['type']).to eq('transaction')

        attributes = @json['data']['attributes']

        expect(attributes['id']).to eq(@transaction_2.id)
        expect(attributes['invoice_id']).to eq(@transaction_2.invoice_id)
        expect(attributes['result']).to eq(@transaction_2.result)
        expect(attributes['credit_card_number']).to eq(@transaction_2.credit_card_number)
      end
    end
  end
end