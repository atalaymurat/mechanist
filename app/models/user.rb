class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :registerable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable, :confirmable
  has_many :people
  has_many :emails

  def username
    return self.email.split(/\W+/ )[1].capitalize
  end

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved? ? super : :not_approved
  end

end
