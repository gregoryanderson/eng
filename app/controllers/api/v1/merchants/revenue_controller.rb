class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    revenue = Invoice.total_revenue_on_date(params[:date])
    render json: RevenueSerializer.new(revenue, params[:date]).to_hash
  end
end