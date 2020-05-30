require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price_in_cents }
    it { should validate_presence_of :merchant_id }
  end

  describe 'relationships' do 
    it { should belong_to :merchant }
  end 

  describe '.import' do
    context 'valid CSV file' do 
      it "imports all customers" do
        filepath = "./spec/fixtures/item_test.csv"
        Merchant.create(name: "Lucy")
        Item.import(filepath)
        expect(Item.count).to eq(5)
      end
    end
  end
end
