require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @c_1 = Customer.create(first_name: "Greg", last_name: "Anderson", id: 1)
    @c_2 = Customer.create(first_name: "Lou", last_name: "Anderson", id: 2)
    @c_3 = Customer.create(first_name: "Nate", last_name: "Anderson", id: 3)
  end

  describe 'when I send a get request to the customers index path' do
    before(:each) do
      get '/api/v1/customers'
      @hash = JSON.parse(response.body)
    end

    it 'I get a JSON:API response containing attributes of all customers' do
      expect(@hash.class).to eq(Hash)
      expect(@hash.keys).to eq(['data'])
      expect(@hash['data'].length).to eq(3)
      expect(@hash['data'].class).to eq(Array)

      expect(@hash['data'][0]['id']).to eq(@c_1.id.to_s)
      expect(@hash['data'][0]['type']).to eq('customer')

      attributes_1 = @hash['data'][0]['attributes']

      expect(attributes_1.class).to eq(Hash)
      expect(attributes_1.length).to eq(3)
      expect(attributes_1['first_name']).to eq(@c_1.first_name.to_s)
      expect(attributes_1['last_name']).to eq(@c_1.last_name.to_s)
      expect(attributes_1['id']).to eq(@c_1.id)

      expect(@hash['data'][1]['id']).to eq(@c_2.id.to_s)
      expect(@hash['data'][1]['type']).to eq('customer')

      attributes_2 = @hash['data'][1]['attributes']

      expect(attributes_2.class).to eq(Hash)
      expect(attributes_2.length).to eq(3)
      expect(attributes_2['first_name']).to eq(@c_2.first_name.to_s)
      expect(attributes_2['last_name']).to eq(@c_2.last_name.to_s)
      expect(attributes_2['id']).to eq(@c_2.id)

      expect(@hash['data'][2]['id']).to eq(@c_3.id.to_s)
      expect(@hash['data'][2]['type']).to eq('customer')

      attributes_3 = @hash['data'][2]['attributes']

      expect(attributes_3.class).to eq(Hash)
      expect(attributes_3.length).to eq(3)
      expect(attributes_3['first_name']).to eq(@c_3.first_name.to_s)
      expect(attributes_3['last_name']).to eq(@c_3.last_name.to_s)
      expect(attributes_3['id']).to eq(@c_3.id)
    end
  end
end