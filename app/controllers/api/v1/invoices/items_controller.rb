class Api::V1::Invoices::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end
end