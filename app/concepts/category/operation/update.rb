require "trailblazer/operation"

class Category::Update < Trailblazer::Operation
  step :empty_id?
  fail :require_id!, fail_fast: true
  step :find_model!
  fail :require_persisted_record!, fail_fast: true
  step :assign_attributes!
  step Contract::Build( constant: Category::Contract::Create )
  step Contract::Validate()
  step Contract::Persist()

  def find_model!(options, id:, **)
    options["model"] = Category.find_by(id: options["id"])
  end

  def empty_id?(options, id:, **)
    id
  end

  def require_id!(options, *)
    options["option_errors"] = "id can't be blank"
  end

  def require_persisted_record!(options, *)
    options["option_errors"] = "Record not found"
  end

  def assign_attributes!(options, params:, **)
    options["model"].assign_attributes(params)

    options["model"]
  end
end