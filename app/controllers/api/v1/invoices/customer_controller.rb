class Api::V1::Invoices::CustomerController < ApplicationController
  def index
    render json: CustomerSerializer.new(Customer.all)
  end

  def show
    render json: CustomerSerializer.new(Customer.find(params[:id]))
  end 
end