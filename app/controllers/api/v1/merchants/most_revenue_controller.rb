class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    found_merchants = Merchant.most_revenue(params[:quantity])
    render json: MerchantSerializer.new(found_merchants)
  end
end