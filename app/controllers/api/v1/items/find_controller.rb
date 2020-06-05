class Api::V1::Items::FindController < ApplicationController
  def show
    render json: ItemSerializer.new(found_records(:ci_find, :find_by))
  end

  def index
    render json: ItemSerializer.new(found_records(:ci_find_all, :where))
  end

  private

  def parameters
    params.permit(:name,
                  :description,
                  :id,
                  :created_at,
                  :updated_at,
                  :merchant_id,
                  :unit_price_in_cents)
  end

  def attribute
    parameters.keys.first
  end

  def value
    parameters.values.first
  end

  def found_records(name_method, other_method)
    if ["name", "description"].include?(attribute)
      Item.send(name_method, attribute, value)
    elsif attribute == 'unit_price'
      formatted_value = value.delete('.').to_i
      Item.send(other_method, attribute => formatted_value)
    else
      Item.send(other_method, attribute => value)
    end
  end
end