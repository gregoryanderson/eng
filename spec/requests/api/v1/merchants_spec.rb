require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant1 = Merchant.create(name: "Greg", id: 1)
    @merchant2 = Merchant.create(name: "Lucy", id: 2)
    @merchant3 = Merchant.create(name: "Buttermilk", id: 3)
    @merchant4 = Merchant.create(name: "Roscoe", id: 4)
  end

  describe 'when I send a get request to the merchants index path' do
    before(:each) do
      get '/api/v1/merchants'
      @merchants = JSON.parse(response.body)
    end

    it 'I get a JSON:API response containing attributes of all merchants' do
      expect(@merchants.class).to eq(Hash)
      expect(@merchants.keys).to eq(['data'])
      expect(@merchants['data'].length).to eq(4)
      expect(@merchants['data'][0]['id']).to eq(@merchant1.id.to_s)
      expect(@merchants['data'][0]['type']).to eq('merchant')
      expect(@merchants['data'][0]['attributes'].class).to eq(Hash)
      expect(@merchants['data'][0]['attributes'].length).to eq(2)
      expect(@merchants['data'][0]['attributes']['name']).to eq(@merchant1.name.to_s)
      expect(@merchants['data'][0]['attributes']['id']).to eq(@merchant1.id)
    end
  end

  describe 'when I send a get request to the merchants show path' do
    before(:each) do
      get "/api/v1/merchants/#{@merchant1.id}"
      @merchants = JSON.parse(response.body)
    end

    it 'I get a JSON:API response containing attributes of all merchants' do
      expect(@merchants.class).to eq(Hash)
      expect(@merchants.keys).to eq(['data'])
      expect(@merchants['data'].length).to eq(3)
      expect(@merchants['data'].class).to eq(Hash)

      expect(@merchants['data']['id']).to eq(@merchant1.id.to_s)
      expect(@merchants['data']['type']).to eq('merchant')
      expect(@merchants['data']['attributes'].class).to eq(Hash)
      expect(@merchants['data']['attributes'].length).to eq(2)
      expect(@merchants['data']['attributes']['name']).to eq(@merchant1.name.to_s)
      expect(@merchants['data']['attributes']['id']).to eq(@merchant1.id)

      expect(@merchants.to_s).not_to include(@merchant2.name.to_s)
    end
  end
end