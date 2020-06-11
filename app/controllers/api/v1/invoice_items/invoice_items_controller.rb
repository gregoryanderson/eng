class Api::V1::InvoiceItems::InvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.all)
  end

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find(params[:id]))
  end 

  def create
    invoice_item = InvoiceItem.new(strong_params)
    if invoice_item.save
      render json: InvoiceItemSerializer.new(invoice_item), status: 201
    else
      render json: error(invoice_item), status: 400
    end
  end

  private 

  def strong_params
    params.permit(:item_id, :invoice_id, :quantity, :unit_price_in_cents)
  end

  def error(object)
    generate_error(detail: error_details(object),
                   parameter: error_parameters(object),
                   title: 'Invalid Request')
  end

  def error_parameters(object)
    object.errors.map do |attribute, _error|
      attribute
    end.join(', ')
  end

  def error_details(object)
    object.errors.full_messages.join(', ') + '.'
  end
end