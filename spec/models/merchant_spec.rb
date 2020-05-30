require 'rails_helper'

RSpec.describe Merchant, type: :model do

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe '.import' do
    context 'valid CSV file' do 
      it "imports all merchants" do
        filename = "./spec/fixtures/merchant_test.csv"
        Merchant.import(filename)
        expect(Merchant.count).to eq(5)
      end
    end
  end
end
