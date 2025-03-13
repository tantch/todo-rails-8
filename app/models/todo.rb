class Todo < ApplicationRecord
  belongs_to :user

  enum :status, { pending: 0, in_progress: 1, completed: 2 }

  validates :title, presence: true #uniqueness: true?
  validates :status, presence: true
end
