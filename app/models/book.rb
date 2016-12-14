class Book < ApplicationRecord
  belongs_to :category
  has_many :rates, dependent: :destroy
  has_many :marks, dependent: :destroy
  has_many :reviews, dependent: :destroy

  scope :order_created_at, ->{order created_at: :desc}
  validates :title, presence: true, 
    length: {maximum: Settings.book.name_max_length}
  validates :description, presence: true,
    length: {maximum: Settings.book.description_max_length}
  validates :number_of_pages, presence: true,
    numericality: {only_integer: true}
  validates :publish_date, presence: true
  validates :author, presence: true,
    length:{maximum: Settings.book.name_max_length}

  mount_uploader :image, PictureUploader
  validate :image_size
  
  private
  def image_size
    if image.size > Settings.book.image_max_size
      errors.add :image, I18n.t("admin.books.max_size_error")
    end
  end
end
