class Book < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :line_items, dependent: :destroy
  has_many :rates, dependent: :destroy
end
