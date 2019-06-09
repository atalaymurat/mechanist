class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :registerable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
  has_many :people
  has_many :emails

  def username
    return self.email.split('@')[0].capitalize
  end

end
