class Api::V1::CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update destroy]

  def index
    @customers = Customer.is_active.all
    if @customers
      render json: @customers, status: :ok
    else
      render json: @customers.errors, status: :bad_request
    end
  end

  def show
    render json: @customer, status: :ok
  end

  def new
    @customer = Customer.new
  end

  def edit; end

  def create
    @customer = Customer.find_or_create_by(customer_params)
    if @customer.save
      render json: @customer, status: :ok
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  def update
    if @customer
      render json: @customer, status: :ok
    else
      render json: @customer.errors, status: :bad_request
    end
  end

  def destroy
    @customer.update(is_archived: true)
    if @customer
      render json: @customer, status: :ok
    else
      render json: @customer.errors, status: :bad_request
    end
  end

  private

  def set_customer
    @customer = Customer.is_active.find(params[:id])
  rescue StandardError => e
    render json: { message: 'Customer not found!' }, status: 404
  end

  def customer_params
    params.require(:customer).permit(:name, :phone_number)
  end
end
