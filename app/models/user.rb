class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :registerable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :registerable, :confirmable
  has_many :people
  has_many :emails
  validates :alias, uniqueness: true
  validates :email, uniqueness: true, presence: true
  before_save :default_values
  mount_uploader :user_picture, ImageUploader
  def default_values
    word = self.email.split("@")
    self.alias = word[0][0..1].upcase + word[1][0..1].upcase if self.alias.blank?
  end
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
