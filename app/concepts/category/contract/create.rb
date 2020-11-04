class Category::Contract::Create < Reform::Form
  include Reform::Form::ActiveModel
  include Reform::Form::ActiveModel::Validations

  property :name
  property :user


  validates :name, presence: true
  validates :user, presence: true
end