class User < ApplicationRecord
  has_many :products

  enum role: [:customer, :restaurant]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
