require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @customer_1 = create(:customer)
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)

    1.times do
      invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant_1)
      item_1 = create(:item, merchant: @merchant_1)
      create(:invoice_item, item: item_1, invoice: invoice_1)
      create(:transaction, invoice: invoice_1)

      invoice_2 = create(:invoice, customer: @customer_1, merchant: @merchant_1)
      item_2 = create(:item, merchant: @merchant_1)
      create(:invoice_item, item: item_2, invoice: invoice_2)
      create(:transaction, invoice: invoice_2, result: 'failed')
    end

    3.times do
      invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant_2)
      item_1 = create(:item, merchant: @merchant_2)
      create(:invoice_item, item: item_1, invoice: invoice_1)
      create(:transaction, invoice: invoice_1)

      invoice_2 = create(:invoice, customer: @customer_1, merchant: @merchant_2)
      item_2 = create(:item, merchant: @merchant_2)
      create(:invoice_item, item: item_2, invoice: invoice_2)
      create(:transaction, invoice: invoice_2, result: 'failed')
    end

    2.times do
      invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant_3)
      item_1 = create(:item, merchant: @merchant_3)
      create(:invoice_item, item: item_1, invoice: invoice_1)
      create(:transaction, invoice: invoice_1)

      invoice_2 = create(:invoice, customer: @customer_1, merchant: @merchant_3)
      item_2 = create(:item, merchant: @merchant_3)
      create(:invoice_item, item: item_2, invoice: invoice_2)
      create(:transaction, invoice: invoice_1, result: 'failed')
    end
  end

  describe 'when I send a request to customers/:id/favorite_merchant' do
    before(:each) do
      get "/api/v1/customers/#{@customer_1.id}/favorite_merchant"
      @json = JSON.parse(response.body)
    end

    it 'I get JSON for merchant customer successfully transacted most with' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].length).to eq(3)
      expect(@json['data'].class).to eq(Hash)

      expect(@json['data']['id']).to eq(@merchant_2.id.to_s)
      expect(@json['data']['type']).to eq('merchant')
      expect(@json['data']['attributes'].class).to eq(Hash)
      expect(@json['data']['attributes'].length).to eq(2)
      expect(@json['data']['attributes']['name']).to eq(@merchant_2.name.to_s)
      expect(@json['data']['attributes']['id']).to eq(@merchant_2.id)
    end
  end
end