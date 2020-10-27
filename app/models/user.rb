class User < ApplicationRecord
  enum role: [:customer, :restaurant]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
