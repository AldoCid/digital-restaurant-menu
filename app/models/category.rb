class Category < ApplicationRecord
  has_many :products
  belongs_to :user

  validates :name, presence: true

  after_update :flip_products if :active_changed?

  def flip_products
    Services::Category::Products::FlipActivation.call(category: self)
  end
end
