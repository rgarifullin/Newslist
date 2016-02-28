class Newsuser < ActiveRecord::Base
  belongs_to :user
  belongs_to :news
end
