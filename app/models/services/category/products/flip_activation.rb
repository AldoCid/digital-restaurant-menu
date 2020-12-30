class Services::Category::Products::FlipActivation < Micro::Case
  attributes :category

  def call!
    if category.products.any?
      category.products.each{|p| p.update(active: category.active?)}
      Success result: {category: category}
    else
      Failure result: {error: 'Category without products!'}
    end
  end
end