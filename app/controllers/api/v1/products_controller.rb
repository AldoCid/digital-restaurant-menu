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
    Services::Create.call(
      model: Product,
      params: product_params.merge({user_id: current_user.id}),
    )
    .on_success { |result| render json: result.data[:record], status: :ok }
    .on_failure { |result| render json: result.data[:error], status: :unprocessable_entity}
  end

  def update
    Services::Flows::FindAndUpdate.call(
      id: params[:id],
      model: Product,
      params: update_product_params
    )
    .on_success { |result| render json: result.data[:record], status: :ok }
    .on_failure(:not_found) { |data| render json: data[:error], status: :not_found }
    .on_failure(:update_failure) { |data| render json: data[:error], status: :unprocessable_entity }
  end

  private

  def product_params
    params.permit(:title, :description, :price, :category_id)
  end

  def update_product_params
    params.permit(:title, :description, :price, :category_id, :active)
  end
end