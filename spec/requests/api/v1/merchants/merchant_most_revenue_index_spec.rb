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

    values = [2,4,1,3,6,5]

    @merchants.each_with_index do |merchant, index|
      10.times do
        invoice = create(:invoice, merchant: merchant)
        create(:transaction, invoice: invoice)
        item = create(:item, merchant: merchant)
        create(:invoice_item,
                invoice: invoice,
                item: item,
                quantity: values[index],
                unit_price_in_cents: values[index])
      end
    end
  end

  describe 'when I send a request to the merchants most revenue route' do
    describe 'and I provide 1 as the quantity' do
      before(:each) do
        get "/api/v1/merchants/most_revenue?quantity=1"
        @hash = JSON.parse(response.body)
      end

      it 'I receive JSON data for 1 merchant with most revenue' do
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].length).to eq(1)

        expect(@hash['data'][0]['id']).to eq(@merchant_5.id.to_s)
        expect(@hash['data'][0]['type']).to eq('merchant')
        expect(@hash['data'][0]['attributes'].class).to eq(Hash)
        expect(@hash['data'][0]['attributes'].length).to eq(2)
        expect(@hash['data'][0]['attributes']['name']).to eq(@merchant_5.name.to_s)
        expect(@hash['data'][0]['attributes']['id']).to eq(@merchant_5.id)
      end
    end

    describe 'and I provide 3 as the quantity' do
      before(:each) do
        get "/api/v1/merchants/most_revenue?quantity=3"
        @hash = JSON.parse(response.body)
      end

      it 'I receive JSON data for 3 merchants with most revenue' do
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].length).to eq(3)

        expect(@hash['data'][0]['id']).to eq(@merchant_5.id.to_s)
        expect(@hash['data'][0]['type']).to eq('merchant')
        expect(@hash['data'][0]['attributes'].class).to eq(Hash)
        expect(@hash['data'][0]['attributes'].length).to eq(2)
        expect(@hash['data'][0]['attributes']['name']).to eq(@merchant_5.name.to_s)
        expect(@hash['data'][0]['attributes']['id']).to eq(@merchant_5.id)

        expect(@hash['data'][1]['id']).to eq(@merchant_6.id.to_s)
        expect(@hash['data'][1]['type']).to eq('merchant')
        expect(@hash['data'][1]['attributes'].class).to eq(Hash)
        expect(@hash['data'][1]['attributes'].length).to eq(2)
        expect(@hash['data'][1]['attributes']['name']).to eq(@merchant_6.name.to_s)
        expect(@hash['data'][1]['attributes']['id']).to eq(@merchant_6.id)

        expect(@hash['data'][2]['id']).to eq(@merchant_2.id.to_s)
        expect(@hash['data'][2]['type']).to eq('merchant')
        expect(@hash['data'][2]['attributes'].class).to eq(Hash)
        expect(@hash['data'][2]['attributes'].length).to eq(2)
        expect(@hash['data'][2]['attributes']['name']).to eq(@merchant_2.name.to_s)
        expect(@hash['data'][2]['attributes']['id']).to eq(@merchant_2.id)
      end
    end

    describe 'and I provide 0 or less as the quantity' do
      before(:each) do
        get "/api/v1/merchants/most_revenue?quantity=-1"
        @hash = JSON.parse(response.body)
      end

      it 'I receive JSON data for 1 merchant with most revenue' do
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].length).to eq(0)
      end
    end

    describe 'and I provide more than the number of records' do
      before(:each) do
        get "/api/v1/merchants/most_revenue?quantity=7"
        @hash = JSON.parse(response.body)
      end

      it 'I receive JSON data for all merchants by most revenue' do
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].length).to eq(6)

        expect(@hash['data'][0]['id']).to eq(@merchant_5.id.to_s)
        expect(@hash['data'][0]['type']).to eq('merchant')
        expect(@hash['data'][0]['attributes'].class).to eq(Hash)
        expect(@hash['data'][0]['attributes'].length).to eq(2)
        expect(@hash['data'][0]['attributes']['name']).to eq(@merchant_5.name.to_s)
        expect(@hash['data'][0]['attributes']['id']).to eq(@merchant_5.id)

        expect(@hash['data'][1]['id']).to eq(@merchant_6.id.to_s)
        expect(@hash['data'][1]['type']).to eq('merchant')
        expect(@hash['data'][1]['attributes'].class).to eq(Hash)
        expect(@hash['data'][1]['attributes'].length).to eq(2)
        expect(@hash['data'][1]['attributes']['name']).to eq(@merchant_6.name.to_s)
        expect(@hash['data'][1]['attributes']['id']).to eq(@merchant_6.id)

        expect(@hash['data'][2]['id']).to eq(@merchant_2.id.to_s)
        expect(@hash['data'][2]['type']).to eq('merchant')
        expect(@hash['data'][2]['attributes'].class).to eq(Hash)
        expect(@hash['data'][2]['attributes'].length).to eq(2)
        expect(@hash['data'][2]['attributes']['name']).to eq(@merchant_2.name.to_s)
        expect(@hash['data'][2]['attributes']['id']).to eq(@merchant_2.id)

        expect(@hash['data'][3]['id']).to eq(@merchant_4.id.to_s)
        expect(@hash['data'][3]['type']).to eq('merchant')
        expect(@hash['data'][3]['attributes'].class).to eq(Hash)
        expect(@hash['data'][3]['attributes'].length).to eq(2)
        expect(@hash['data'][3]['attributes']['name']).to eq(@merchant_4.name.to_s)
        expect(@hash['data'][3]['attributes']['id']).to eq(@merchant_4.id)

        expect(@hash['data'][4]['id']).to eq(@merchant_1.id.to_s)
        expect(@hash['data'][4]['type']).to eq('merchant')
        expect(@hash['data'][4]['attributes'].class).to eq(Hash)
        expect(@hash['data'][4]['attributes'].length).to eq(2)
        expect(@hash['data'][4]['attributes']['name']).to eq(@merchant_1.name.to_s)
        expect(@hash['data'][4]['attributes']['id']).to eq(@merchant_1.id)

        expect(@hash['data'][5]['id']).to eq(@merchant_3.id.to_s)
        expect(@hash['data'][5]['type']).to eq('merchant')
        expect(@hash['data'][5]['attributes'].class).to eq(Hash)
        expect(@hash['data'][5]['attributes'].length).to eq(2)
        expect(@hash['data'][5]['attributes']['name']).to eq(@merchant_3.name.to_s)
        expect(@hash['data'][5]['attributes']['id']).to eq(@merchant_3.id)
      end
    end
  end
end