class Api::V1::Invoices::FindController < ApplicationController
  
  def show
    render json: InvoiceSerializer.new(found_records(:ci_find, :find_by))
  end

  def index
    render json: InvoiceSerializer.new(found_records(:ci_find_all, :where))
  end

  private

  def parameters
    params.permit(:id,
                  :created_at,
                  :updated_at,
                  :merchant_id,
                  :customer_id,
                  :status)
  end

  def attribute
    parameters.keys.first
  end

  def value
    parameters.values.first
  end

  def found_records(name_method, other_method)
    if attribute == 'status'
      Invoice.send(name_method, attribute, value)
    else
      Invoice.send(other_method, attribute => value)
    end
  end
end