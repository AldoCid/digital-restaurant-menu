class Category::Contract::Create < Reform::Form
  include Reform::Form::ActiveModel
  include Reform::Form::ActiveModel::Validations

  property :name

  validates :name, presence: true
end