class Api::V1::Transactions::TransactionsController < ApplicationController
  def show
    render json: TransactionSerializer.new(Transaction.find(params[:id]))
  end

  def index
    render json: TransactionSerializer.new(Transaction.all)
  end
end