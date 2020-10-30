class User < ApplicationRecord
  has_many :products
  has_many :categories

  enum role: [:customer, :restaurant]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
