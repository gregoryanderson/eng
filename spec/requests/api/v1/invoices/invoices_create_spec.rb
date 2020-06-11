require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Alfred's", id: 1)
    @customer = Customer.create(first_name: "Greg", last_name: "Anderson", id: 1)
  end

  describe 'when I send a get request to the invoices new_item path' do
    before(:each) do
      post "/api/v1/invoices/new", params: {  "merchant_id": 1,
                                              "customer_id": 1,
                                              "status": "lost"
                                            }
      @status_code = response.status
      @hash = JSON.parse(response.body)
      @new_invoice = Invoice.last
    end

    it 'an invoice is created in the database' do
      expect(@new_invoice.status).to eq("lost")
      expect(@new_invoice.customer_id).to eq(1)
      expect(@new_invoice.merchant_id).to eq(1)
    end

    it 'I receive a status code 201' do
      expect(@status_code).to eq(201)
    end

    skip 'and I receive a JSON:API response containing a unique id for that user' do
      expect(@response).to include(
        'data' => {
          'id' => @new_item.id.to_s
        }
      )
    end
  end
end