class Api::V1::CategoriesController < Api::ApiController

  def index
    render json: current_user.categories.to_json, status: :ok
  end

  def show
    Services::Find.call(
      model: Category,
      id: params[:id]
    )
    .on_success { |result| render json: result.data[:record], status: :ok }
    .on_failure { |result| render json: result.data[:error], status: :not_found }
  end

  def create
    Services::Create.call(
      model: Category,
      params: category_params.merge({user_id: current_user.id}),
    )
    .on_success { |result| render json: result.data[:record], status: :ok }
    .on_failure { |result| render json: result.data[:error], status: :unprocessable_entity }
  end

  def update
    Services::Flows::FindAndUpdate.call(
      id: params[:id],
      model: Category,
      params: category_params
    )
    .on_success { |result| render json: result.data[:record], status: :ok }
    .on_failure(:not_found) { |data| render json: data[:error], status: :not_found }
    .on_failure(:update_failure) { |data| render json: data[:error], status: :unprocessable_entity }
  end

  private

  def category_params
    params.permit(:name)
  end
end