class Api::V1::Transactions::FindController < ApplicationController
  def show
    render json: TransactionSerializer.new(found_records(:ci_find, :find_by))
  end

  def index
    render json: TransactionSerializer.new(found_records(:ci_find_all, :where))
  end

  private

  def parameters
    params.permit(:id,
                  :created_at,
                  :updated_at,
                  :invoice_id,
                  :credit_card_number,
                  :result)
  end

  def attribute
    parameters.keys.first
  end

  def value
    parameters.values.first
  end

  def found_records(name_method, other_method)
    if attribute == 'result'
      Transaction.send(name_method, attribute, value)
    else
      Transaction.send(other_method, attribute => value)
    end
  end
end