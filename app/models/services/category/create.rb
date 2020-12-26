class Services::Category::Create < Micro::Case
  attributes :params, :user

  def call!
    begin
      category = Category.new.tap do |category|
        category.assign_attributes(params)
        category.user = user
      end

      if category.save
        Success result: {category: category}
      else
        Failure result: {error: category.errors}
      end
    rescue StandardError => e
      Failure result: {error: e}
    end
  end
end