require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Greg", id: 1)
    @customer = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
    @invoice = Invoice.create(merchant_id: 1, customer_id: 1, id: 1, status: "shipped")
    @transaction_1 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 1, invoice_id: 1)
    @transaction_2 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "failed", id: 2, invoice_id: 1)
    @transaction_3 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 3, invoice_id: 1)
  end 

  describe 'when I send a delete request to the transactions delete path' do
    before(:each) do
      delete "/api/v1/transactions/#{@transaction_1.id}/delete"
      @status_code = response.status
    end

    it 'a merchant is deleted in the database' do
      expect(Transaction.all.length).to eq(2)
      expect(Transaction.first.result).to eq("failed")

    end

    it 'I receive a status code 204' do
      expect(@status_code).to eq(204)
    end
  end
end