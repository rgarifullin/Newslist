class News < ActiveRecord::Base
  has_many :newsusers
  has_many :users, through: :newsusers
end
