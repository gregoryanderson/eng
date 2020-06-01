require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @m_1 = Merchant.create(name: "Greg", id: 1)
    @m_2 = Merchant.create(name: "Greg", id: 2)
    @m_3 = Merchant.create(name: "Lala", id: 3, created_at: Time.zone.parse('2020-01-10'))
    @m_4 = Merchant.create(name: "Mama", id: 4, created_at: Time.zone.parse('2020-01-10'))
    @m_5 = Merchant.create(name: "Papa", id: 5, updated_at: Time.zone.parse('2020-01-15'))
    @m_6 = Merchant.create(name: "Tata", id: 6, updated_at: Time.zone.parse('2020-01-15'))
    @m_7 = Merchant.create(name: "Baba", id: 7, updated_at: Time.zone.parse('2020-01-15'))
    @m_8 = Merchant.create(name: "Rara", id: 8)
  end

  describe 'when I send a get request to the merchants find index path' do
    describe 'by their name attribute (case-insensitive)' do
      before(:each) do
        get "/api/v1/merchants/find_all?name=#{@m_2.name.downcase}"
        @hash = JSON.parse(response.body)
      end

      it 'I get a JSON response with attributes of all matching merchants' do
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].class).to eq(Array)
        expect(@hash['data'].length).to eq(2)

        expect(@hash['data'][0]['id']).to eq(@m_1.id.to_s)
        expect(@hash['data'][0]['type']).to eq('merchant')
        expect(@hash['data'][0]['attributes'].class).to eq(Hash)
        expect(@hash['data'][0]['attributes'].length).to eq(2)
        expect(@hash['data'][0]['attributes']['name']).to eq(@m_1.name.to_s)
        expect(@hash['data'][0]['attributes']['id']).to eq(@m_1.id)

        expect(@hash['data'][1]['id']).to eq(@m_2.id.to_s)
        expect(@hash['data'][1]['type']).to eq('merchant')
        expect(@hash['data'][1]['attributes'].class).to eq(Hash)
        expect(@hash['data'][1]['attributes'].length).to eq(2)
        expect(@hash['data'][1]['attributes']['name']).to eq(@m_2.name.to_s)
        expect(@hash['data'][1]['attributes']['id']).to eq(@m_2.id)

        expect(@hash.to_s).not_to include(@m_3.name.to_s)
        expect(@hash.to_s).not_to include(@m_4.name.to_s)
        expect(@hash.to_s).not_to include(@m_5.name.to_s)
        expect(@hash.to_s).not_to include(@m_6.name.to_s)
        expect(@hash.to_s).not_to include(@m_7.name.to_s)
        expect(@hash.to_s).not_to include(@m_8.name.to_s)
      end
    end

    describe 'by their id attribute' do
      before(:each) do
        get "/api/v1/merchants/find_all?id=#{@m_8.id}"
        @hash = JSON.parse(response.body)
      end

      it 'I get a JSON response with attributes of all matching merchants' do
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].class).to eq(Array)
        expect(@hash['data'].length).to eq(1)

        expect(@hash['data'][0]['id']).to eq(@m_8.id.to_s)
        expect(@hash['data'][0]['type']).to eq('merchant')
        expect(@hash['data'][0]['attributes'].class).to eq(Hash)
        expect(@hash['data'][0]['attributes'].length).to eq(2)
        expect(@hash['data'][0]['attributes']['name']).to eq(@m_8.name.to_s)
        expect(@hash['data'][0]['attributes']['id']).to eq(@m_8.id)

        expect(@hash.to_s).not_to include(@m_1.name.to_s)
        expect(@hash.to_s).not_to include(@m_2.name.to_s)
        expect(@hash.to_s).not_to include(@m_3.name.to_s)
        expect(@hash.to_s).not_to include(@m_4.name.to_s)
        expect(@hash.to_s).not_to include(@m_5.name.to_s)
        expect(@hash.to_s).not_to include(@m_6.name.to_s)
        expect(@hash.to_s).not_to include(@m_7.name.to_s)
      end
    end

    describe 'by their created_at attribute' do
      before(:each) do
        get "/api/v1/merchants/find_all?created_at=#{@m_3.created_at}"
        @hash = JSON.parse(response.body)
      end

      it 'I get a JSON response with attributes of all matching merchants' do
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].class).to eq(Array)
        expect(@hash['data'].length).to eq(2)

        expect(@hash['data'][0]['id']).to eq(@m_3.id.to_s)
        expect(@hash['data'][0]['type']).to eq('merchant')
        expect(@hash['data'][0]['attributes'].class).to eq(Hash)
        expect(@hash['data'][0]['attributes'].length).to eq(2)
        expect(@hash['data'][0]['attributes']['name']).to eq(@m_3.name.to_s)
        expect(@hash['data'][0]['attributes']['id']).to eq(@m_3.id)

        expect(@hash['data'][1]['id']).to eq(@m_4.id.to_s)
        expect(@hash['data'][1]['type']).to eq('merchant')
        expect(@hash['data'][1]['attributes'].class).to eq(Hash)
        expect(@hash['data'][1]['attributes'].length).to eq(2)
        expect(@hash['data'][1]['attributes']['name']).to eq(@m_4.name.to_s)
        expect(@hash['data'][1]['attributes']['id']).to eq(@m_4.id)

        expect(@hash.to_s).not_to include(@m_1.name.to_s)
        expect(@hash.to_s).not_to include(@m_2.name.to_s)
        expect(@hash.to_s).not_to include(@m_5.name.to_s)
        expect(@hash.to_s).not_to include(@m_6.name.to_s)
        expect(@hash.to_s).not_to include(@m_7.name.to_s)
        expect(@hash.to_s).not_to include(@m_8.name.to_s)
      end
    end

    describe 'by their updated_at attribute' do
      before(:each) do
        get "/api/v1/merchants/find_all?updated_at=#{@m_5.updated_at}"
        @hash = JSON.parse(response.body)
      end

      it 'I get a JSON response with attributes of all matching merchants' do
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].class).to eq(Array)
        expect(@hash['data'].length).to eq(3)

        expect(@hash['data'][0]['id']).to eq(@m_5.id.to_s)
        expect(@hash['data'][0]['type']).to eq('merchant')
        expect(@hash['data'][0]['attributes'].class).to eq(Hash)
        expect(@hash['data'][0]['attributes'].length).to eq(2)
        expect(@hash['data'][0]['attributes']['name']).to eq(@m_5.name.to_s)
        expect(@hash['data'][0]['attributes']['id']).to eq(@m_5.id)

        expect(@hash['data'][1]['id']).to eq(@m_6.id.to_s)
        expect(@hash['data'][1]['type']).to eq('merchant')
        expect(@hash['data'][1]['attributes'].class).to eq(Hash)
        expect(@hash['data'][1]['attributes'].length).to eq(2)
        expect(@hash['data'][1]['attributes']['name']).to eq(@m_6.name.to_s)
        expect(@hash['data'][1]['attributes']['id']).to eq(@m_6.id)

        expect(@hash['data'][2]['id']).to eq(@m_7.id.to_s)
        expect(@hash['data'][2]['type']).to eq('merchant')
        expect(@hash['data'][2]['attributes'].class).to eq(Hash)
        expect(@hash['data'][2]['attributes'].length).to eq(2)
        expect(@hash['data'][2]['attributes']['name']).to eq(@m_7.name.to_s)
        expect(@hash['data'][2]['attributes']['id']).to eq(@m_7.id)

        expect(@hash.to_s).not_to include(@m_1.name.to_s)
        expect(@hash.to_s).not_to include(@m_2.name.to_s)
        expect(@hash.to_s).not_to include(@m_3.name.to_s)
        expect(@hash.to_s).not_to include(@m_4.name.to_s)
        expect(@hash.to_s).not_to include(@m_8.name.to_s)
      end
    end
  end
end