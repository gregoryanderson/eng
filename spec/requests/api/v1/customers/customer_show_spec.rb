require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @customer_1 = Customer.create(first_name: "Greg", last_name: "Anderson", id: 1)
    @customer_2 = Customer.create(first_name: "Billy", last_name: "Anderson", id: 2)
  end

  describe 'when I send a get request to the customers show path' do
    before(:each) do
      get "/api/v1/customers/#{@customer_1.id}"
      @hash = JSON.parse(response.body)
      @attributes = @hash['data']['attributes']
    end

    it 'I get a JSON:API response containing attributes of all customers' do
      expect(@hash.class).to eq(Hash)
      expect(@hash.keys).to eq(['data'])
      expect(@hash['data'].length).to eq(3)
      expect(@hash['data'].class).to eq(Hash)
      expect(@hash['data']['id']).to eq(@customer_1.id.to_s)
      expect(@hash['data']['type']).to eq('customer')

      expect(@attributes.class).to eq(Hash)
      expect(@attributes.length).to eq(3)
      expect(@attributes['first_name']).to eq(@customer_1.first_name.to_s)
      expect(@attributes['last_name']).to eq(@customer_1.last_name.to_s)
      expect(@attributes['id']).to eq(@customer_1.id)

      expect(@hash.to_s).not_to include(@customer_2.id.to_s)
    end
  end
end