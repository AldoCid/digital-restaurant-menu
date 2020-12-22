class Api::V1::CategoriesController < Api::ApiController

  def index
    render json: current_user.categories.to_json, status: :ok
  end

  def show
    render json: Category.find(params[:id]), status: :ok
  end

  def create
    result = Category::Create.(
      params: category_params,
      user: current_user
    )

    if result.success?
      render json: result["model"], status: :ok
    else
      render json: result[:'contract.default'].errors, status: :unprocessable_entity
    end
  end

  def update
    result = Category::Update.(
      id: params[:id],
      params: category_params
    )

    if result.success?
      render json: result["model"], status: :ok
    else
      render json: result[:'contract.default'].errors, status: :unprocessable_entity
    end
  end


  private

  def category_params
    params.permit(:name)
  end
end