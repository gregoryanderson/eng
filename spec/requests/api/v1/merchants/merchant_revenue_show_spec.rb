require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)
    @merchant_5 = create(:merchant)
    @merchant_6 = create(:merchant)

    @merchants = [@merchant_1,
                  @merchant_2,
                  @merchant_3,
                  @merchant_4,
                  @merchant_5,
                  @merchant_6]

    # 6 x 10 x 100 = $60.00 revenue
    @merchants.each_with_index do |merchant, index|
      10.times do
        invoice = create(:invoice, merchant: merchant, created_at: '2012-03-16')
        create(:transaction, invoice: invoice)
        item = create(:item, merchant: merchant)
        create(:invoice_item,
                invoice: invoice,
                item: item,
                quantity: 1,
                unit_price_in_cents: 100)
      end
    end

    # 6 x 5 x 100 = $30.00 revenue
    @merchants.each_with_index do |merchant, index|
      5.times do
        invoice = create(:invoice, merchant: merchant, created_at: '2012-03-07')
        create(:transaction, invoice: invoice)
        item = create(:item, merchant: merchant)
        create(:invoice_item,
                invoice: invoice,
                item: item,
                quantity: 1,
                unit_price_in_cents: 100)
      end
    end
  end

  describe 'when I send a request to the merchants/revenue endpoint' do
    describe 'with a date parameter with a valid date string in the DB' do
      before(:each) do
        get "/api/v1/merchants/revenue?date=2012-03-16"
        @json = JSON.parse(response.body)
      end

      it 'I receive JSON data with total revenue across merchants on date' do
        expect(@json.class).to eq(Hash)
        expect(@json.length).to eq(1)
        expect(@json['data'].class).to eq(Hash)
        expect(@json['data'].length).to eq(1)

        attributes = @json['data']['attributes']
        expect(attributes.length).to eq(1)
        expect(attributes['total_revenue']).to eq("60.00")
      end
    end

    describe 'with a date parameter with a date not in the dataset' do
      before(:each) do
        get "/api/v1/merchants/revenue?date=2012-05-23"
        @json = JSON.parse(response.body)
      end

      it 'I receive JSON data with total revenue across merchants on date' do
        expect(@json.class).to eq(Hash)
        expect(@json.length).to eq(1)
        expect(@json['data'].class).to eq(Hash)
        expect(@json['data'].length).to eq(1)

        attributes = @json['data']['attributes']
        expect(attributes.length).to eq(1)
        expect(attributes['total_revenue']).to eq("0.00")
      end
    end
  end
end