require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @customer = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
    @merchant_1 = Merchant.create(name: "Greg", id: 1)
    @merchant_2 = Merchant.create(name: "Greg", id: 2)
    @merchant_3 = Merchant.create(name: "Greg", id: 3)
    @invoice_1 = Invoice.create(merchant_id: 1, customer_id: 1, id: 1, status: "shipped")
    @invoice_2 = Invoice.create(merchant_id: 2, customer_id: 1, id: 2, status: "shipped")
    @invoice_3 = Invoice.create(merchant_id: 3, customer_id: 1, id: 3, status: "shipped")
    @transaction_1 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 1, invoice_id: 1)
    @transaction_2 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 2, invoice_id: 2)
    @transaction_3 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 3, invoice_id: 3)
  end

  describe 'when I send a request to the customers-transactions endpoint' do
    before(:each) do
      get "/api/v1/customers/#{@customer.id}/transactions"
      @json = JSON.parse(response.body)
    end

    it 'I get JSON data for all transactions associated with customer' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].class).to eq(Array)
      expect(@json['data'].length).to eq(3)

      exp = [@transaction_1, @transaction_2, @transaction_3]
      @json['data'].each_with_index do |item, index|
        expect(item['id']).to eq(exp[index].id.to_s)
        expect(item['type']).to eq('transaction')

        atts = item['attributes']

        expect(atts['id']).to eq(exp[index].id)
        expect(atts['invoice_id']).to eq(exp[index].invoice_id)
        expect(atts['credit_card_number']).to eq(exp[index].credit_card_number)
        expect(atts['result']).to eq(exp[index].result)
      end
    end
  end
end