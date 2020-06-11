RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = Merchant.create(name: "Gregs", id: 1)
    @customer = Customer.create(first_name: "Lucy", last_name: "Conklin", id: 1)
    @item = Item.create(name: "Thing One", description: "Thing one is this thing", unit_price_in_cents: 12345, id: 1, merchant_id: 1)

    @invoice_1 = Invoice.create(merchant_id: 1, customer_id: 1, id: 1, status: "shipped")
    @invoice_2 = Invoice.create(merchant_id: 1, customer_id: 1, id: 2, status: "lost")
    @invoice_3 = Invoice.create(merchant_id: 1, customer_id: 1, id: 3, status: "shipped")

    @invoice_item_1 = InvoiceItem.create(item_id: 1, invoice_id: 1, id: 1, quantity: 1, unit_price_in_cents: 12345)
    @invoice_item_2 = InvoiceItem.create(item_id: 1, invoice_id: 2, id: 2, quantity: 1, unit_price_in_cents: 33333)
    @invoice_item_3 = InvoiceItem.create(item_id: 1, invoice_id: 3, id: 3, quantity: 1, unit_price_in_cents: 12345)

    @transaction_1 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 1, invoice_id: 1)
    @transaction_2 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "charged", id: 2, invoice_id: 2)
    @transaction_3 = Transaction.create(credit_card_number: 1111222233334444, credit_card_expiration_date: '2020', result: "declined", id: 3, invoice_id: 3)

  end 

  describe 'when I send a delete request to the items delete path' do
    before(:each) do
      delete "/api/v1/invoices/#{@invoice_1.id}/delete"
      @status_code = response.status
    end

    it 'an invoice_item is deleted in the database' do
      expect(Invoice.all.length).to eq(2)
      expect(Invoice.first.status).to eq("lost")

      expect(InvoiceItem.all.length).to eq(2)
      expect(InvoiceItem.first.unit_price_in_cents).to eq(33333)

      expect(Transaction.all.length).to eq(2)
      expect(Transaction.last.result).to eq("declined")

    end

    it 'I receive a status code 204' do
      expect(@status_code).to eq(204)
    end
  end
end