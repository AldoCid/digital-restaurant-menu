class Api::V1::ProductsController < Api::ApiController

  def index
    render json: current_user.products.to_json, status: :ok
  end

  def show
    Services::Find.call(
      model: Product,
      id: params[:id]
    )
    .on_success { |result| render json: result.data[:record], status: :ok }
    .on_failure { |result| render json: result.data[:error], status: :not_found }
  end

  def create
    Services::Product::Create.call(
      params: product_params,
      user_id: current_user.id
    )
    .on_success { |result| render json: result.data[:product], status: :ok }
    .on_failure { |result| render json: result.data[:error], status: :unprocessable_entity}
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