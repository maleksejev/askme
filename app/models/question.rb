class Question < ApplicationRecord
  validates :text, :user, presence: true
  validates_length_of :text, maximum: 255
end
