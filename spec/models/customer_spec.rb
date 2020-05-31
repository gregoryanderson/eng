require 'rails_helper'

RSpec.describe Customer, type: :model do

  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe '.import' do
    context 'valid CSV file' do 
      it "imports all customers" do
        filename = "./spec/fixtures/customer_test.csv"
        Customer.import(filename)
        expect(Customer.count).to eq(5)
      end
    end
  end
end