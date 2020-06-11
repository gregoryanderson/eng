require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant_1 = Merchant.create(name: "Alfred's", id: 1)
    @merchant_2 = Merchant.create(name: "Lulu's", id: 2)
    @customer_1 = Customer.create(first_name: "Greg", last_name: "Anderson", id: 1)
    @customer_2 = Customer.create(first_name: "Buttermilk", last_name: "Anderconk", id: 2)
    @invoice_1 = Invoice.create(customer_id: 1, merchant_id: 1, id: 1, status: 'shipped')
  end 

  describe 'when I send a get request to the items update path' do
    before(:each) do
      post "/api/v1/invoices/#{@invoice_1.id}/update", 
            params: {
                      customer_id: 2,  
                      merchant_id: 2, 
                      status: "lost"
                    }
      @status_code = response.status
    end

    it 'an item is updated in the database' do
      expect(Invoice.first.customer_id).to eq(2)
      expect(Invoice.first.status).to eq("lost")
      expect(Invoice.first.merchant_id).to eq(2)
    end

    it 'I receive a status code 200' do
      expect(@status_code).to eq(200)
    end
  end
end