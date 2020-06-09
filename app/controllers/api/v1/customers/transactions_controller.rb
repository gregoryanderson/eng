class Api::V1::Customers::TransactionsController < ApplicationController
  def index
    transactions = Customer.find(params[:id]).transactions
    render json: TransactionSerializer.new(transactions)
  end
end