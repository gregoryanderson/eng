class Api::V1::Invoices::TransactionsController < ApplicationController
  def show
    render json: TransactionSerializer.new(Transaction.find(params[:id]))
  end 
end