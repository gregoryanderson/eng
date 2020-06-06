require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @c_3 = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 3)
    @c_5 = Customer.create(first_name: "Dara", last_name: "Conklin", id: 4)
    @c_7 = Customer.create(first_name: "Lucy", last_name: "Ellie", id: 5)
    @c_1 = Customer.create(first_name: "Greg", last_name: "Anderson", id: 1, created_at: Time.zone.parse('2020-01-01'))
    @c_2 = Customer.create(first_name: "Al", last_name: "Allen", id: 2, updated_at: Time.zone.parse('2020-01-02'))
    @c_4 = Customer.create(first_name: "Fred", last_name: "Fredricks", id: 6, created_at: Time.zone.parse('2020-01-01'))
    @c_6 = Customer.create(first_name: "George", last_name: "Guinn", id: 7)
    @c_8 = Customer.create(first_name: "Heidi", last_name: "Henderson", id: 8, updated_at: Time.zone.parse('2020-01-02'))

    # Provide plural name of resource being requested; interpolated below.
    @resources = "customers"
  end

  describe "when I send a get request to the #{@resources} find index path" do

    # One block per possible search parameter
    describe 'by their (case-insensitive) first_name attribute' do
      before(:each) do
        # Get request using attribute of one of the matching resources
        get "/api/v1/#{@resources}/find_all?first_name=#{@c_3.first_name.upcase}"

        # Assign response to instance variable
        @hash = JSON.parse(response.body)
      end

      it "I get a JSON response with attributes of all matching #{@resources}" do
        # Test general attributes of response hash
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].class).to eq(Array)
        expect(@hash['data'].length).to eq(2)

        # Test attributes of individual resources in 'data'
        expect(@hash['data'][0]['id']).to eq(@c_3.id.to_s)
        expect(@hash['data'][0]['type']).to eq('customer')

        attributes_1 = @hash['data'][0]['attributes']

        expect(attributes_1.class).to eq(Hash)
        expect(attributes_1.length).to eq(3)
        expect(attributes_1['first_name']).to eq(@c_3.first_name.to_s)
        expect(attributes_1['last_name']).to eq(@c_3.last_name.to_s)
        expect(attributes_1['id']).to eq(@c_3.id)

        expect(@hash['data'][1]['id']).to eq(@c_7.id.to_s)
        expect(@hash['data'][1]['type']).to eq('customer')

        attributes_2 = @hash['data'][1]['attributes']

        expect(attributes_2.class).to eq(Hash)
        expect(attributes_2.length).to eq(3)
        expect(attributes_2['first_name']).to eq(@c_7.first_name.to_s)
        expect(attributes_2['last_name']).to eq(@c_7.last_name.to_s)
        expect(attributes_2['id']).to eq(@c_7.id)

        # Test that non-matching resources' attributes are not present
        expect(@hash.to_s).not_to include(@c_1.first_name)
        expect(@hash.to_s).not_to include(@c_2.first_name)
        expect(@hash.to_s).not_to include(@c_4.first_name)
        expect(@hash.to_s).not_to include(@c_5.first_name)
        expect(@hash.to_s).not_to include(@c_6.first_name)
        expect(@hash.to_s).not_to include(@c_8.first_name)
      end
    end

    describe 'by their last_name attribute (case-insensitive)' do
      before(:each) do
        # Get request using attribute of one of the matching resources
        get "/api/v1/#{@resources}/find_all?last_name=#{@c_5.last_name.upcase}"

        # Assign response to instance variable
        @hash = JSON.parse(response.body)
      end

      it "I get a JSON response with attributes of all matching #{@resources}" do
        # Test general attributes of response hash
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].class).to eq(Array)
        expect(@hash['data'].length).to eq(2)

        # Test attributes of individual resources in 'data'
        expect(@hash['data'][0]['id']).to eq(@c_3.id.to_s)
        expect(@hash['data'][0]['type']).to eq('customer')

        attributes_1 = @hash['data'][0]['attributes']

        expect(attributes_1.class).to eq(Hash)
        expect(attributes_1.length).to eq(3)
        expect(attributes_1['first_name']).to eq(@c_3.first_name.to_s)
        expect(attributes_1['last_name']).to eq(@c_3.last_name.to_s)
        expect(attributes_1['id']).to eq(@c_3.id)

        expect(@hash['data'][1]['id']).to eq(@c_5.id.to_s)
        expect(@hash['data'][1]['type']).to eq('customer')

        attributes_2 = @hash['data'][1]['attributes']

        expect(attributes_2.class).to eq(Hash)
        expect(attributes_2.length).to eq(3)
        expect(attributes_2['first_name']).to eq(@c_5.first_name.to_s)
        expect(attributes_2['last_name']).to eq(@c_5.last_name.to_s)
        expect(attributes_2['id']).to eq(@c_5.id)

        # Test that non-matching resources are not present
        expect(@hash.to_s).not_to include(@c_1.last_name)
        expect(@hash.to_s).not_to include(@c_2.last_name)
        expect(@hash.to_s).not_to include(@c_4.last_name)
        expect(@hash.to_s).not_to include(@c_6.last_name)
        expect(@hash.to_s).not_to include(@c_7.last_name)
        expect(@hash.to_s).not_to include(@c_8.last_name)
      end
    end

    describe 'by their created_at attribute' do
      before(:each) do
        # Get request using attribute of one of the matching resources
        get "/api/v1/#{@resources}/find_all?created_at=#{@c_1.created_at}"

        # Assign response to instance variable
        @hash = JSON.parse(response.body)
      end

      it "I get a JSON response with attributes of all matching #{@resources}" do
        # Test general attributes of response hash
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].class).to eq(Array)
        expect(@hash['data'].length).to eq(2)

        # Test attributes of individual resources in 'data'
        expect(@hash['data'][0]['id']).to eq(@c_1.id.to_s)
        expect(@hash['data'][0]['type']).to eq('customer')

        attributes_1 = @hash['data'][0]['attributes']

        expect(attributes_1.class).to eq(Hash)
        expect(attributes_1.length).to eq(3)
        expect(attributes_1['first_name']).to eq(@c_1.first_name.to_s)
        expect(attributes_1['last_name']).to eq(@c_1.last_name.to_s)
        expect(attributes_1['id']).to eq(@c_1.id)

        expect(@hash['data'][1]['id']).to eq(@c_4.id.to_s)
        expect(@hash['data'][1]['type']).to eq('customer')

        attributes_2 = @hash['data'][1]['attributes']

        expect(attributes_2.class).to eq(Hash)
        expect(attributes_2.length).to eq(3)
        expect(attributes_2['first_name']).to eq(@c_4.first_name.to_s)
        expect(attributes_2['last_name']).to eq(@c_4.last_name.to_s)
        expect(attributes_2['id']).to eq(@c_4.id)

        # Test that non-matching resources are not present
        expect(@hash.to_s).not_to include(@c_2.created_at.to_s)
        expect(@hash.to_s).not_to include(@c_3.created_at.to_s)
        expect(@hash.to_s).not_to include(@c_5.created_at.to_s)
        expect(@hash.to_s).not_to include(@c_6.created_at.to_s)
        expect(@hash.to_s).not_to include(@c_7.created_at.to_s)
        expect(@hash.to_s).not_to include(@c_8.created_at.to_s)
      end
    end

    describe 'by their updated_at attribute)' do
      before(:each) do
        # Get request using attribute of one of the matching resources
        get "/api/v1/#{@resources}/find_all?updated_at=#{@c_2.updated_at}"

        # Assign response to instance variable
        @hash = JSON.parse(response.body)
      end

      it "I get a JSON response with attributes of all matching #{@resources}" do
        # Test general attributes of response hash
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].class).to eq(Array)
        expect(@hash['data'].length).to eq(2)

        # Test attributes of individual resources in 'data'
        expect(@hash['data'][0]['id']).to eq(@c_2.id.to_s)
        expect(@hash['data'][0]['type']).to eq('customer')

        attributes_1 = @hash['data'][0]['attributes']

        expect(attributes_1.class).to eq(Hash)
        expect(attributes_1.length).to eq(3)
        expect(attributes_1['first_name']).to eq(@c_2.first_name.to_s)
        expect(attributes_1['last_name']).to eq(@c_2.last_name.to_s)
        expect(attributes_1['id']).to eq(@c_2.id)

        expect(@hash['data'][1]['id']).to eq(@c_8.id.to_s)
        expect(@hash['data'][1]['type']).to eq('customer')

        attributes_2 = @hash['data'][1]['attributes']

        expect(attributes_2.class).to eq(Hash)
        expect(attributes_2.length).to eq(3)
        expect(attributes_2['first_name']).to eq(@c_8.first_name.to_s)
        expect(attributes_2['last_name']).to eq(@c_8.last_name.to_s)
        expect(attributes_2['id']).to eq(@c_8.id)

        # Test that non-matching resources are not present
        expect(@hash.to_s).not_to include(@c_1.updated_at.to_s)
        expect(@hash.to_s).not_to include(@c_3.updated_at.to_s)
        expect(@hash.to_s).not_to include(@c_4.updated_at.to_s)
        expect(@hash.to_s).not_to include(@c_5.updated_at.to_s)
        expect(@hash.to_s).not_to include(@c_6.updated_at.to_s)
        expect(@hash.to_s).not_to include(@c_7.updated_at.to_s)

      end
    end

    describe 'by their id attribute' do
      before(:each) do
        # Get request using attribute of one of the matching resources
        get "/api/v1/#{@resources}/find_all?id=#{@c_6.id}"

        # Assign response to instance variable
        @hash = JSON.parse(response.body)
      end

      it "I get a JSON response with attributes of all matching #{@resources}" do
        # Test general attributes of response hash
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].class).to eq(Array)
        expect(@hash['data'].length).to eq(1)

        # Test attributes of individual resources in 'data'
        expect(@hash['data'][0]['id']).to eq(@c_6.id.to_s)
        expect(@hash['data'][0]['type']).to eq('customer')

        attributes_1 = @hash['data'][0]['attributes']

        expect(attributes_1.class).to eq(Hash)
        expect(attributes_1.length).to eq(3)
        expect(attributes_1['first_name']).to eq(@c_6.first_name.to_s)
        expect(attributes_1['last_name']).to eq(@c_6.last_name.to_s)
        expect(attributes_1['id']).to eq(@c_6.id)

        # Test that non-matching resources are not present
        expect(@hash.to_s).not_to include(@c_1.id.to_s)
        expect(@hash.to_s).not_to include(@c_2.id.to_s)
        expect(@hash.to_s).not_to include(@c_3.id.to_s)
        expect(@hash.to_s).not_to include(@c_4.id.to_s)
        expect(@hash.to_s).not_to include(@c_5.id.to_s)
        expect(@hash.to_s).not_to include(@c_7.id.to_s)
        expect(@hash.to_s).not_to include(@c_8.id.to_s)
      end
    end
  end
end