class Category < ApplicationRecord
  acts_as_paranoid
  has_many :books, dependent: :destroy
  scope :select_fields, ->{select :id, :name}

  validates :name, presence: true,
    length: {maximum: Settings.max_length_name_category}
  class << self
    def hot_categories
      category_ids = Category.joins(:books).order("count_books_id DESC")
        .group(:id).limit(Settings.hot_items.limit).count("books.id").keys
      Category.select_fields.find category_ids
    end
  end

  scope :category_attributes_select, (lambda do
    select :id, :name, :created_at, :updated_at
  end)
end
