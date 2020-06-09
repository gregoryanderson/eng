require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Greg", id: 1)
    @customer = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
    @invoice = Invoice.create(merchant_id: 1, customer_id: 1, id: 1, status: "shipped")
    @transaction = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 1, invoice_id: 1)
  end

  describe 'when I send a get request to the transactions show path' do
    before(:each) do
      get "/api/v1/transactions/#{@transaction.id}"
      @json = JSON.parse(response.body)
    end

    it 'I get a JSON:API response containing attributes of transaction' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].length).to eq(3)

      expect(@json['data']['id']).to eq(@transaction.id.to_s)
      expect(@json['data']['type']).to eq('transaction')

      attributes = @json['data']['attributes']

      expect(attributes['id']).to eq(@transaction.id)
      expect(attributes['invoice_id']).to eq(@transaction.invoice_id)
      expect(attributes['result']).to eq(@transaction.result)
      expect(attributes['credit_card_number']).to eq(@transaction.credit_card_number)
    end
  end
end