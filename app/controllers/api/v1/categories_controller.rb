class Api::V1::CategoriesController < Api::ApiController

  def index
    render json: current_user.categories.to_json, status: :ok
  end

  def show
    render json: Category.find(params[:id]), status: :ok
  end

  def create
    Services::Category::Create.call(
      params: category_params,
      user: current_user
    )
    .on_success { |result| render json: result.data[:category], status: :ok }
    .on_failure { |result| render json: result.data[:error], status: :unprocessable_entity }
  end

  def update
    Services::Category::Update.call(
      id: params[:id],
      params: category_params
    )
    .on_success { |result| render json: result.data[:category], status: :ok }
    .on_failure { |result| render json: result.data[:error], status: :unprocessable_entity }
  end

  private

  def category_params
    params.permit(:name)
  end
end