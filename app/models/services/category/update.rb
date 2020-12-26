class Services::Category::Update < Micro::Case
  attributes :params, :id

  def call!
    begin
      category = Category.find(id)
      if category.update(params)
        Success result: {category: category.reload}
      else
        Failure result: {error: category.errors}
      end
    rescue StandardError => e
      Failure result: {error: e}
    end
  end
end