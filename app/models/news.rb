class News < ActiveRecord::Base
  has_many :newsusers
  has_many :users, through: :newsusers

  validates :author, presence: true, length: { minimum: 5 }
  validates :text, presence: true, length: { minimum: 15 }
end
