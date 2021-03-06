class Api::V1::ProductsController < ApplicationController
  before_action :authentication

  def index
    products = Product.all
    render json: products, status: :ok
  end

  def create
    product = Product.new(
      name: prod_params[:name],
      brand: prod_params[:brand],
      price: prod_params[:price],
      description: prod_params[:description],
    )

    if product.save
      render json: product, status: :ok
    else
      render json: { error: "Error creating review." }
    end

  end

  def show
    product - Product.find_by(id: params[:id])

    if product
      render json: product, status: :ok
    else
      render json: { error: "Product Not Found" }
    end

  end

  private
    def prod_params
      params.require(:product).permit([
        :name,
        :brand,
        :price,
        :description
      ])
    end

    def test
      puts 'TESTESTESTEST!!!!____!!___!__!_!_!__999'
    end

end
