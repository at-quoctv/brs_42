class Mark < ApplicationRecord
  belongs_to :book
  belongs_to :user

  enum mark_type: [:unread, :read, :reading]

  scope :favorite_book_ids_of_user, -> user_id do
    where(user_id: user_id, is_favorite: true).pluck :book_id
  end
end
