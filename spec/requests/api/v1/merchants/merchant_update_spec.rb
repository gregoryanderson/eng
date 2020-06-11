require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Lucy", id: 1)
  end 

  describe 'when I send a post request to the merchants update path' do
    before(:each) do
      post "/api/v1/merchants/#{@merchant.id}/update", params: {name:"Greg"}
      @status_code = response.status
    end

    it 'a user is updated in the database' do
      expect(Merchant.first.name).to eq("Greg")
      expect(Merchant.first.id).to eq(1)
    end

    it 'I receive a status code 200' do
      expect(@status_code).to eq(200)
    end
  end
end