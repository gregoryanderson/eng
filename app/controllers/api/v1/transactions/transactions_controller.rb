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


  def destroy
    transaction = Transaction.find(params[:id])
    if transaction
      Transaction.delete(transaction)
    else 
      flash[:notice] = "Something went wrong with your deletion"
      render json: error(transaction), status: 400
    end
  end 


  def update
    transaction = Transaction.find(params[:id])
    if transaction.update(strong_params)
     render json: transaction
    else
     render json: transaction.errors, status: :unprocessable_entity
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