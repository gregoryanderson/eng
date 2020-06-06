class Api::V1::Customers::FindController < ApplicationController
  def show
    render json: CustomerSerializer.new(found_records(:ci_find, :find_by))
  end

  def index
    render json: CustomerSerializer.new(found_records(:ci_find_all, :where))
  end

  private

  def parameters
    params.permit(:first_name, :last_name, :id, :created_at, :updated_at)
  end

  def attribute
    parameters.keys.first
  end

  def value
    parameters.values.first
  end

  def found_records(name_method, other_method)
    if ["first_name", "last_name"].include?(attribute)
      Customer.send(name_method, attribute, value)
    else
      Customer.send(other_method, attribute => value)
    end
  end
end