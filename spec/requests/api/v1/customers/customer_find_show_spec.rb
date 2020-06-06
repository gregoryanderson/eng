require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @customer_1 = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1, created_at: Time.zone.parse('2020-01-01'))
    @customer_2 = Customer.create(first_name: "Billy", last_name: "Conklin", id: 2)
    @customer_3 = Customer.create(first_name: "Bobby", last_name: "Conklin", id: 3, updated_at: Time.zone.parse('2020-01-02'))
    @customer_4 = Customer.create(first_name: "Betsy", last_name: "Conklin", id: 4)
  end

  describe 'when I send a get request to the customers find path' do
    describe 'by its first_name attribute case-insensitive' do
      before(:each) do
        get "/api/v1/customers/find?first_name=#{@customer_2.first_name.downcase}"
        @hash = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that customer' do
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
        expect(@hash.to_s).not_to include(@customer_4.id.to_s)
      end
    end

    describe 'by its last_name attribute case-insensitive' do
      before(:each) do
        get "/api/v1/customers/find?last_name=#{@customer_1.last_name.downcase}"
        @hash = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that customer' do
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].length).to eq(3)
        expect(@hash['data'].class).to eq(Hash)
        expect(@hash['data']['id']).to eq(@customer_1.id.to_s)
        expect(@hash['data']['type']).to eq('customer')

        attributes = @hash['data']['attributes']
        expect(attributes.class).to eq(Hash)
        expect(attributes.length).to eq(3)
        expect(attributes['first_name']).to eq(@customer_1.first_name.to_s)
        expect(attributes['last_name']).to eq(@customer_1.last_name.to_s)
        expect(attributes['id']).to eq(@customer_1.id)

        expect(@hash.to_s).not_to include(@customer_2.id.to_s)
        expect(@hash.to_s).not_to include(@customer_3.id.to_s)
        expect(@hash.to_s).not_to include(@customer_4.id.to_s)
      end
    end

    describe 'by its id attribute' do
      before(:each) do
        get "/api/v1/customers/find?id=#{@customer_4.id}"
        @hash = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that customer' do
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].length).to eq(3)
        expect(@hash['data'].class).to eq(Hash)
        expect(@hash['data']['id']).to eq(@customer_4.id.to_s)
        expect(@hash['data']['type']).to eq('customer')

        attributes = @hash['data']['attributes']
        expect(attributes.class).to eq(Hash)
        expect(attributes.length).to eq(3)
        expect(attributes['first_name']).to eq(@customer_4.first_name.to_s)
        expect(attributes['last_name']).to eq(@customer_4.last_name.to_s)
        expect(attributes['id']).to eq(@customer_4.id)

        expect(@hash.to_s).not_to include(@customer_1.id.to_s)
        expect(@hash.to_s).not_to include(@customer_2.id.to_s)
        expect(@hash.to_s).not_to include(@customer_3.id.to_s)
      end
    end

    describe 'by its created_at attribute' do
      before(:each) do
        get "/api/v1/customers/find?created_at=#{@customer_1.created_at}"
        @hash = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that customer' do
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].length).to eq(3)
        expect(@hash['data'].class).to eq(Hash)
        expect(@hash['data']['id']).to eq(@customer_1.id.to_s)
        expect(@hash['data']['type']).to eq('customer')

        attributes = @hash['data']['attributes']
        expect(attributes.class).to eq(Hash)
        expect(attributes.length).to eq(3)
        expect(attributes['first_name']).to eq(@customer_1.first_name.to_s)
        expect(attributes['last_name']).to eq(@customer_1.last_name.to_s)
        expect(attributes['id']).to eq(@customer_1.id)

        expect(@hash.to_s).not_to include(@customer_2.id.to_s)
        expect(@hash.to_s).not_to include(@customer_3.id.to_s)
        expect(@hash.to_s).not_to include(@customer_4.id.to_s)
      end
    end

    describe 'by its updated_at attribute' do
      before(:each) do
        get "/api/v1/customers/find?updated_at=#{@customer_3.updated_at}"
        @hash = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that customer' do
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].length).to eq(3)
        expect(@hash['data'].class).to eq(Hash)
        expect(@hash['data']['id']).to eq(@customer_3.id.to_s)
        expect(@hash['data']['type']).to eq('customer')

        attributes = @hash['data']['attributes']
        expect(attributes.class).to eq(Hash)
        expect(attributes.length).to eq(3)
        expect(attributes['first_name']).to eq(@customer_3.first_name.to_s)
        expect(attributes['last_name']).to eq(@customer_3.last_name.to_s)
        expect(attributes['id']).to eq(@customer_3.id)

        expect(@hash.to_s).not_to include(@customer_1.id.to_s)
        expect(@hash.to_s).not_to include(@customer_2.id.to_s)
        expect(@hash.to_s).not_to include(@customer_4.id.to_s)
      end
    end
  end
end