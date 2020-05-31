require 'rails_helper'

RSpec.describe Invoice, type: :model do

  describe 'validations' do
    it { should validate_presence_of :customer_id }
    it { should validate_presence_of :merchant_id }
    it { should validate_presence_of :status }
  end

  describe 'relationships' do 
    it { should belong_to :customer }
    it { should belong_to :merchant }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end 

  describe '.import' do
    context 'valid CSV file' do 
      skip "imports all invoices" do
        filename = "./spec/fixtures/invoice_test.csv"
        Customer.find_or_create_by(first_name: "Greg", last_name: "Anderson")
        Merchant.find_or_create_by(name: "Lucy")
        Invoice.import(filename)
        expect(Invoice.count).to eq(5)
      end
    end
  end
end
