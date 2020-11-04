require "trailblazer/operation"

class Category::Create < Trailblazer::Operation

  step Model(Category, :create)
  step Contract::Build( constant: Category::Contract::Create )
  step Contract::Validate()
  step Contract::Persist()
end