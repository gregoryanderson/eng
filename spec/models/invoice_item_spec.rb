require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do

  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price_in_cents }
  end

  describe 'relationships' do
    it { should belong_to :item }
    it { should belong_to :invoice }
  end

  describe '.import' do
    context 'valid CSV file' do 
      skip "imports all customers" do
        filename = "./spec/fixtures/invoice_item_test.csv"
        InvoiceItem.import(filename)
        expect(InvoiceItem.count).to eq(5)
      end
    end
  end
end
