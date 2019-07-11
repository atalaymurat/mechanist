class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :registerable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable
  has_many :people
  has_many :emails

  def username
    return self.email.split(/\W+/ )[1].capitalize
  end

end
