
class Api::V1::Items::InvoiceItemsController < ApplicationController
  def index
    invoice_items = Item.find(params[:id]).invoice_items
    render json: InvoiceItemSerializer.new(invoice_items)
  end
end