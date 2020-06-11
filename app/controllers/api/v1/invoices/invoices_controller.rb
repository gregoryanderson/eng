class Api::V1::Invoices::InvoicesController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Invoice.all)
  end

  def show
    render json: InvoiceSerializer.new(Invoice.find(params[:id]))
  end 

  def create
    invoice = Invoice.new(strong_params)
    if invoice.save
      render json: InvoiceSerializer.new(invoice), status: 201
    else
      render json: error(invoice), status: 400
    end
  end

  private 

  def strong_params
    params.permit(:merchant_id, :customer_id, :status)
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