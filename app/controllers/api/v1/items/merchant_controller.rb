class Api::V1::Items::MerchantController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end
end