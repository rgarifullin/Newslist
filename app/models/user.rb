class User < ActiveRecord::Base
  ROLES = %i[moderator viewer]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable

  has_many :newsusers
  has_many :news, through: :newsusers
end
