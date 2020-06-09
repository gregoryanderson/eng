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
      id_number = customer.id
      Customer.delete(customer)
      render json: id_number, status: 204
    else 
      flash[:notice] = "Something went wrong with your deletion"
      render json: error(customer), status: 400
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