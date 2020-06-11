class Api::V1::Items::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item = Item.new(strong_params)
    if item.save
      render json: ItemSerializer.new(item), status: 201
    else
      render json: error(item), status: 400
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item
      invoice_items = InvoiceItem.where(item_id: item.id)
      InvoiceItem.delete(invoice_items)
      Item.delete(item)
    else 
      flash[:notice] = "Something went wrong with your deletion"
      render json: error(item), status: 400
    end
  end 

  private 

  def strong_params
    params.permit(:name, :description, :merchant_id, :unit_price_in_cents)
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