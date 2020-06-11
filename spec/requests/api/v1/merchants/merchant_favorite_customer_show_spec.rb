# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = create(:merchant)
    @merchant_2 = create(:merchant)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    @invoice_1 = create(:invoice, merchant: @merchant, customer: @customer_1)
    @transaction_1 = create(:transaction, invoice: @invoice_1)
    @invoice_2 = create(:invoice, merchant: @merchant, customer: @customer_1)
    @transaction_2 = create(:transaction, invoice: @invoice_2, result: 'failed')

    @invoice_3 = create(:invoice, merchant: @merchant, customer: @customer_2)
    @transaction_3 = create(:transaction, invoice: @invoice_3)
    @invoice_4 = create(:invoice, merchant: @merchant, customer: @customer_2)
    @transaction_4 = create(:transaction, invoice: @invoice_4)
    @invoice_5 = create(:invoice, merchant: @merchant, customer: @customer_2)
    @transaction_5 = create(:transaction, invoice: @invoice_5, result: 'failed')

    @invoice_6 = create(:invoice, merchant: @merchant, customer: @customer_3)
    @transaction_6 = create(:transaction, invoice: @invoice_6)

    @invoice_7 = create(:invoice, merchant: @merchant_2, customer: @customer_4)
    @transaction_7 = create(:transaction, invoice: @invoice_7)
    @invoice_8 = create(:invoice, merchant: @merchant_2, customer: @customer_4)
    @transaction_8 = create(:transaction, invoice: @invoice_8, result: 'failed')

    @invoice_9 = create(:invoice, merchant: @merchant_2, customer: @customer_5)
    @transaction_9 = create(:transaction, invoice: @invoice_9)
    @invoice_10 = create(:invoice, merchant: @merchant_2, customer: @customer_5)
    @transaction_10 = create(:transaction, invoice: @invoice_10)
    @invoice_11 = create(:invoice, merchant: @merchant_2, customer: @customer_5)
    @transaction_11 = create(:transaction, invoice: @invoice_11, result: 'failed')

    @invoice_12 = create(:invoice, merchant: @merchant_2, customer: @customer_6)
    @transaction_12 = create(:transaction, invoice: @invoice_12)
  end

  describe 'when I send a get request to the merchants/:id/favorite_customer path' do
    before(:each) do
      get "/api/v1/merchants/#{@merchant.id}/favorite_customer"
      @hash = JSON.parse(response.body)
    end

    it 'I get JSON:API data for customer with most successful transactions' do
      expect(@hash.class).to eq(Hash)
      expect(@hash.keys).to eq(['data'])
      expect(@hash['data'].length).to eq(3)
      expect(@hash['data'].class).to eq(Hash)
      expect(@hash['data']['id']).to eq(@customer_2.id.to_s)
      expect(@hash['data']['type']).to eq('customer')

      attributes = @hash['data']['attributes']
      expect(attributes.class).to eq(Hash)
      expect(attributes.length).to eq(3)
      expect(attributes['first_name']).to eq(@customer_2.first_name.to_s)
      expect(attributes['last_name']).to eq(@customer_2.last_name.to_s)
      expect(attributes['id']).to eq(@customer_2.id)

      expect(@hash.to_s).not_to include(@customer_1.id.to_s)
      expect(@hash.to_s).not_to include(@customer_3.id.to_s)
    end
  end
end