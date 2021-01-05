class Services::Product::Create < Micro::Case
  attributes :params, :user_id

  def call!
    begin
      product = Product.new(params)
      product.user_id = user_id

      if product.save
        Success result: {product: product}
      else
        Failure result: {error: product.errors}
      end
    rescue StandardError => e
      Failure result: {error: e}
    end
  end
end