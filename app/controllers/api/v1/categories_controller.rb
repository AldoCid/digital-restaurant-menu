class Api::V1::CategoriesController < Api::ApiController

  def index
    render json: current_user.categories.to_json, status: :ok
  end

  def show
    render json: Category.find(params[:id]), status: :ok
  end

  def create
    require 'pry'; binding.pry
    result = run Category::Create.(params: category_params, user: current_user )

    render json: result["model"], status: :ok if result.success?

    render json: @form.errors.messages, status: :unprocessable_entity

    # new_category = Category.new(name: category_params[:name], user: current_user )
    # if new_category.save
    #   render json: new_category, status: :ok
    # else
    #   render json: new_category.errors, status: :unprocessable_entity
    # end
  end

  def update
    category = Category.find(params[:id])
    if category.update(category_params)
      render json: category, status: :ok
    else
      render json: category.errors, status: :unprocessable_entity
    end
  end


  private

  def category_params
    params.permit(:name)
  end
end