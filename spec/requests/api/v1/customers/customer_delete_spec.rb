require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @customer_1 = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
    @customer_2 = Customer.create(first_name: "Dara", last_name: "Conklin", id: 2)
    @merchant = Merchant.create(name: "Gregs", id: 1)
    @invoice_1 = Invoice.create(merchant_id: 1, customer_id: 1, id: 1, status: "shipped")
    @invoice_1 = Invoice.create(merchant_id: 1, customer_id: 2, id: 2, status: "shipped")
    @transaction_1 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 1, invoice_id: 1)
    @transaction_2 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 2, invoice_id: 2)
  end 

  describe 'when I send a get request to the customers delete path' do
    before(:each) do
      delete "/api/v1/customers/#{@customer_1.id}/delete"
      @status_code = response.status
      # @hash = JSON.parse(response.body)
    end

    it 'a user is created in the database' do
      expect(Customer.all.length).to eq(1)
      expect(Customer.first.first_name).to eq("Dara")
      expect(Invoice.all.length).to eq(1)
      expect(Transaction.all.length).to eq(1)
    end

    it 'I receive a status code 201' do
      expect(@status_code).to eq(204)
    end
  end
end