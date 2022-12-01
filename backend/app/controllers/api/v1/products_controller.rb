class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[show]

  def index
    @products = Product.is_active.all
    if @products
      render json: @products, status: :ok
    else
      render json: @products.errors, status: :bad_request
    end
  end

  def show
    render json: @product, status: :ok
  end

  private

  def set_product
    @product = Product.find(params[:id])
  rescue StandardError => e
    render json: { message: 'Product not found.' }, status: 404
  end

  def product_params
    params.require(:product).permit(:title,
                                    :description,
                                    :price,
                                    :quantity,
                                    :is_archived)
  end
end
