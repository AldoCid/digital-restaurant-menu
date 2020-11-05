require "trailblazer/operation"

class Category::Create < Trailblazer::Operation
  step :initialize_model!
  step :assign_user!
  fail :no_user!
  step Contract::Build( constant: Category::Contract::Create )
  step Contract::Validate()
  step Contract::Persist()

  def initialize_model!(options, params:, **)
    options["model"] = Category.new(params)
  end

  def assign_user!(options, user:, **)
    options["model"].user = options["user"]

    options["user"] != nil
  end

  def no_user!(options, *)
    options["option_errors"] = "user can't be blank"
  end
end