class Api::V1::Merchants::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end 

  def create
    merchant = Merchant.new(strong_params)
    if merchant.save
      render json: MerchantSerializer.new(merchant), status: 201
    else
      render json: error(merchant), status: 400
    end
  end

  def destroy
    merchant = Merchant.find(params[:id])
    if merchant
      invoices = Invoice.where(merchant_id: merchant.id)
      # invoice_ids = invoices.pluck(:id)
      items = Item.where(merchant_id: merchant.id)
      Item.delete(items)
      Invoice.delete(invoices)
      Merchant.delete(merchant)
    else 
      flash[:notice] = "Something went wrong with your deletion"
      render json: error(merchant), status: 400
    end
  end 

  private 

  def strong_params
    params.permit(:name)
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