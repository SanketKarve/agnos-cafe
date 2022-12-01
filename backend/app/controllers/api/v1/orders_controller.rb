class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: %i[show]

  def show
    render json: @order, include: { purchases: { include: :product } }, status: :ok
  end

  def create
    customer_id = params[:customer_id]
    @order = Order.create(customer_id: customer_id)
    if params[:products].present?
      params[:products].map do |product|
        puts product
        @order.purchases.create(customer_id: customer_id, product_id: product[:id], quantity: product[:quantity])
      end
    end
    if @order.save
      render json: @order, include: { purchases: { include: :product } }, status: :ok
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  rescue StandardError => e
    render json: { message: 'order not found.' }, status: 404
  end
end
