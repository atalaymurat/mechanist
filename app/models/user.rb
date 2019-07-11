class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :registerable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable, :confirmable
  has_many :people
  has_many :emails
  validates :alias, uniqueness: true
  validates :email, uniqueness: true, presence: true
  mount_uploader :user_picture, ImageUploader
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
