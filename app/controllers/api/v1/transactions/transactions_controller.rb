class Api::V1::Transactions::TransactionsController < ApplicationController
  def show
    render json: TransactionSerializer.new(Transaction.find(params[:id]))
  end

  def index
    render json: TransactionSerializer.new(Transaction.all)
  end

  def create
    transaction = Transaction.new(strong_params)
    if transaction.save
      render json: TransactionSerializer.new(transaction), status: 201
    else
      render json: error(transaction), status: 400
    end
  end

  private 

  def strong_params
    params.permit(:credit_card_number, :credit_card_expiration_date, :result, :invoice_id)
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