class Api::V1::Invoices::MerchantController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end 
end