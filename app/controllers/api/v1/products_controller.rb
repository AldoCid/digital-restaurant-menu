class Api::V1::ProductsController < Api::ApiController

  def index
    render json: current_user.products.to_json, status: :ok
  end

  def show
    render json: Product.find(params[:id]), status: :ok
  end

  def create
    product = Product.new.tap do |p|
      p.assign_attributes(product_params)
      p.user = current_user
    end

    if product.save
      render json: product.to_json, status: :ok
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  def update
    begin
      product = Product.find(params[:id])
      if product.update(update_product_params)
        render json: product.to_json, status: :ok
      else
        render json: product.errors, status: :unprocessable_entity
      end
    rescue StandardError => e
      render json: {error: e}, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.permit(:title, :description, :price, :category_id)
  end

  def update_product_params
    params.permit(:title, :description, :price, :category_id, :active)
  end
end