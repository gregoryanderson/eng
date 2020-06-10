class Api::V1::Customers::CustomersController < ApplicationController
  def index
    render json: CustomerSerializer.new(Customer.all)
  end

  def show
    render json: CustomerSerializer.new(Customer.find(params[:id]))
  end

  def create
    customer = Customer.new(strong_params)
    if customer.save
      render json: CustomerSerializer.new(customer), status: 201
    else
      render json: error(customer), status: 400
    end
  end

  def destroy
    customer = Customer.find(params[:id])
    if customer
      invoices = Invoice.where(customer_id: customer.id)
      invoice_ids = invoices.pluck(:id)
      transactions = Transaction.where(invoice_id: invoice_ids)
      Transaction.delete(transactions)
      Invoice.delete(invoices)
      Customer.delete(customer)
    else 
      flash[:notice] = "Something went wrong with your deletion"
      render json: error(customer), status: 400
    end
  end 

  def update
    customer = Customer.find(params[:id])
    if customer.update(strong_params)
     render json: customer
    else
     render json: customer.errors, status: :unprocessable_entity
    end
  end

  private 

  def strong_params
    params.permit(:first_name, :last_name)
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