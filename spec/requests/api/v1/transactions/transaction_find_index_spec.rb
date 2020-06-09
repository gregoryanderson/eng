require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Greg", id: 1)
    @customer = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
    @invoice = Invoice.create(merchant_id: 1, customer_id: 1, id: 1, status: "shipped")
    @invoice_2 = Invoice.create(merchant_id: 1, customer_id: 1, id: 2, status: "shipped")
    @transaction_1 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 1, invoice_id: 1)  # unique id, first 'success'
    @transaction_2 = Transaction.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2020', result: "failed", id: 2, invoice_id: 1) # unique #
    @transaction_3 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 3, invoice_id: 1, created_at: '2020-02-02') # unique created_at
    @transaction_4 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 4, invoice_id: 1, updated_at: '1985-10-22') # unique updated_at
    @transaction_5 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "borked", id: 5, invoice_id: 1) # unique result
    @transaction_6 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "failed", id: 6, invoice_id: 1)
    @transaction_7 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 7, invoice_id: 2) # unique invoice_id
    @transaction_2a = Transaction.create(credit_card_number: 1234123412341234, credit_card_expiration_date: '2020', result: "charged", id: 8, invoice_id: 1)
    @transaction_3a = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 9, invoice_id: 1, created_at: '2020-02-02') # unique created_at
    @transaction_4a = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 10, invoice_id: 1, updated_at: '1985-10-22') # unique updated_at
    @transaction_5a = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "borked", id: 11, invoice_id: 1) # unique result
    @transaction_6a = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "failed", id: 12, invoice_id: 1)
    @transaction_7a = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 13, invoice_id: 2) # unique invoice_id
  end

  describe 'when I send a get request to the transactions find_all path' do
    describe 'by its id attribute' do
      before(:each) do
        get "/api/v1/transactions/find_all?id=#{@transaction_1.id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(1)

        expected = [@transaction_1]
        @json['data'].each_with_index do |transaction, index|
          expect(transaction['id']).to eq(expected[index].id.to_s)
          expect(transaction['type']).to eq('transaction')

          attributes = transaction['attributes']

          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['result']).to eq(expected[index].result)
          expect(attributes['credit_card_number']).to eq(expected[index].credit_card_number)
        end
      end
    end

    describe 'by its (case-insensitive) result attribute' do
      before(:each) do
        get "/api/v1/transactions/find_all?result=#{@transaction_5.result.upcase}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@transaction_5, @transaction_5a]
        @json['data'].each_with_index do |transaction, index|
          expect(transaction['id']).to eq(expected[index].id.to_s)
          expect(transaction['type']).to eq('transaction')

          attributes = transaction['attributes']

          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['result']).to eq(expected[index].result)
          expect(attributes['credit_card_number']).to eq(expected[index].credit_card_number)
        end
      end
    end

    describe 'by its created_at attribute' do
      before(:each) do
        get "/api/v1/transactions/find_all?created_at=#{@transaction_3.created_at}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@transaction_3, @transaction_3a]
        @json['data'].each_with_index do |transaction, index|
          expect(transaction['id']).to eq(expected[index].id.to_s)
          expect(transaction['type']).to eq('transaction')

          attributes = transaction['attributes']

          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['result']).to eq(expected[index].result)
          expect(attributes['credit_card_number']).to eq(expected[index].credit_card_number)
        end      end
    end

    describe 'by its updated_at attribute' do
      before(:each) do
        get "/api/v1/transactions/find_all?updated_at=#{@transaction_4.updated_at}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@transaction_4, @transaction_4a]
        @json['data'].each_with_index do |transaction, index|
          expect(transaction['id']).to eq(expected[index].id.to_s)
          expect(transaction['type']).to eq('transaction')

          attributes = transaction['attributes']

          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['result']).to eq(expected[index].result)
          expect(attributes['credit_card_number']).to eq(expected[index].credit_card_number)
        end
      end
    end

    describe 'by its invoice_id attribute' do
      before(:each) do
        get "/api/v1/transactions/find_all?invoice_id=#{@transaction_7.invoice_id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@transaction_7, @transaction_7a]
        @json['data'].each_with_index do |transaction, index|
          expect(transaction['id']).to eq(expected[index].id.to_s)
          expect(transaction['type']).to eq('transaction')

          attributes = transaction['attributes']

          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['result']).to eq(expected[index].result)
          expect(attributes['credit_card_number']).to eq(expected[index].credit_card_number)
        end
      end
    end

    describe 'by its credit_card_number attribute' do
      before(:each) do
        get "/api/v1/transactions/find_all?credit_card_number=#{@transaction_2.credit_card_number}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@transaction_2, @transaction_2a]
        @json['data'].each_with_index do |transaction, index|
          expect(transaction['id']).to eq(expected[index].id.to_s)
          expect(transaction['type']).to eq('transaction')

          attributes = transaction['attributes']

          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['result']).to eq(expected[index].result)
          expect(attributes['credit_card_number']).to eq(expected[index].credit_card_number)
        end
      end
    end
  end
end