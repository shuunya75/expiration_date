class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :foods, dependent: :destroy
  has_one :profile, dependent: :destroy

  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'user.png'
    end
  end
end
