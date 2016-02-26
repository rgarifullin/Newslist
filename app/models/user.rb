class User < ActiveRecord::Base
  enum role: { user: 0, admin: 1 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :newsusers
  has_many :news, through: :newsusers
end
