require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Greg", id: 1)
    @customer = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
    @invoice = Invoice.create(merchant_id: 1, customer_id: 1, id: 1, status: "shipped")
  end

  describe 'when I send a post request to the transactions new path' do
    before(:each) do
      post "/api/v1/transactions/new", 
            params: { 
                      "credit_card_number": 1111222233334444,
                      "credit_card_expiration_date": "2020",
                      "result": "failed",
                      "invoice_id": 1
                    }
      @status_code = response.status
      @hash = JSON.parse(response.body)
      @new_transaction = Transaction.last
    end

    it 'a transaction is created in the database' do
      expect(@new_transaction.credit_card_number).to eq("1111222233334444")
      expect(@new_transaction.result).to eq("failed")
      expect(@new_transaction.invoice_id).to eq(1)
    end

    it 'I receive a status code 201' do
      expect(@status_code).to eq(201)
    end

    skip 'and I receive a JSON:API response with a unique id for that merchant' do
      expect(@response).to include(
        'data' => {
          'id' => @new_customer.id.to_s
        }
      )
    end
  end
end