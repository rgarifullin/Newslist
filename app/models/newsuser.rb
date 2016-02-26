class Newsuser < ActiveRecord::Base
  belong_to :user
  belongs_to :news
end
