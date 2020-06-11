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

  def destroy
    invoice_item = InvoiceItem.find(params[:id])
    if invoice_item
      InvoiceItem.delete(invoice_item)
    else 
      flash[:notice] = "Something went wrong with your deletion"
      render json: error(invoice_item), status: 400
    end
  end 

  def update
    invoice_item = InvoiceItem.find(params[:id])
    if invoice_item.update(strong_params)
     render json: invoice_item
    else
     render json: invoice_item.errors, status: :unprocessable_entity
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