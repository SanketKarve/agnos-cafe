class Api::V1::PaymentsController < ApplicationController
  before_action :set_payment, only: %i[show]
  require 'securerandom'

  def create
    @order = Order.find(params[:order_id])
    if @order.present?
      @payments = @order.payments.new
      @payments.mode = :online
      @payments.amount = @order.net_price
      @payments.transaction_id = SecureRandom.alphanumeric
      @payments.status = :success
      if @payments.save
        render json: @payments, status: :ok
      else
        render json: @payments.errors, status: :bad_request
      end
    else
      render json: { message: 'Order not found!' }, status: 404
    end
  end

  def show
    render json: @payment, status: :ok
  end

  private

  def set_payment
    @payment = Payment.find(params[:id])
  rescue StandardError => e
    render json: { message: 'payment not found.' }, status: 404
  end
end
