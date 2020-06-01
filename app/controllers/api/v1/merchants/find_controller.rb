class Api::V1::Merchants::FindController < ApplicationController
  
  def index
    merchants = if parameters[:name]
                  merchants = Merchant.ci_name_find_all(parameters[:name])
                else
                  merchants = Merchant.where(parameters)
                end
    render json: MerchantSerializer.new(merchants)
  end

  private

  def parameters
    params.permit(:name, :id, :created_at, :updated_at)
  end
end