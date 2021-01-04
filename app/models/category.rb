class Category < ApplicationRecord
  has_many :products
  belongs_to :user

  validates :name, presence: true

  after_save :flip_products_activation

  def flip_products_activation
    Services::Category::Products::FlipActivation.call(category: self) if saved_change_to_active?
  end
end
