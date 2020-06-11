require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Greg", id: 1)
    @customer = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
    @invoice = Invoice.create(merchant_id: 1, customer_id: 1, id: 1, status: "shipped")
    @invoice_2 = Invoice.create(merchant_id: 1, customer_id: 1, id: 2, status: "shipped")

    @transaction_1 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 1, invoice_id: 1)
  end 

  describe 'when I send a post request to the transactions update path' do
    before(:each) do
      post "/api/v1/transactions/#{@transaction_1.id}/update", 
            params: {
                      credit_card_number: 4444444444444444,
                      result: "failed",
                      invoice_id: 2
                    }
      @status_code = response.status
    end

    it 'a transaction is updated in the database' do
      expect(Transaction.first.credit_card_number).to eq("4444444444444444")
      expect(Transaction.first.result).to eq("failed")
      expect(Transaction.first.invoice_id).to eq(2)
    end

    it 'I receive a status code 200' do
      expect(@status_code).to eq(200)
    end
  end
end