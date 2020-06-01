namespace :import do
  task all: :environment do
    Transaction.destroy_all
    InvoiceItem.destroy_all
    Invoice.destroy_all
    Item.destroy_all
    Merchant.destroy_all
    Customer.destroy_all

    Customer.import('./lib/tasks/data/customer.csv')
    puts "Complete 1"
    Merchant.import('./lib/tasks/data/merchant.csv')
    puts "Complete 2"
    Item.import('./lib/tasks/data/item.csv')
    puts "Complete 3"
    Invoice.import('./lib/tasks/data/invoice.csv')
    puts "Complete 4"
    InvoiceItem.import('./lib/tasks/data/invoiceitem.csv')
    puts "Complete 5"
    Transaction.import('./lib/tasks/data/transaction.csv')
    puts "Complete 6"

    puts Customer.count
    puts Merchant.count
    puts Item.count
    puts Invoice.count
    puts InvoiceItem.count
    puts Transaction.count

  end
end