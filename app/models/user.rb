class User < ActiveRecord::Base
  enum role: { user: 0, admin: 1 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :newsusers
  has_many :news, through: :newsusers

  def read?(current_user, news)
    newsuser = current_user.newsusers.find_by(news_id: news)
    newsuser && newsuser.read ? true : false
  end
end
