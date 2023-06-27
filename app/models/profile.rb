class Profile < ApplicationRecord
  validates :nickname, presence: true
  validates :nickname, length: {maximum: 13}

  validates :my_id, presence: true
  validates :my_id, {uniqueness: true}
  validates :my_id, length: {maximum: 10}
  
  belongs_to :user

  has_one_attached :avatar

  def avatar_image
    if avatar&.attached?
      avatar
    else
      'user.png'
    end
  end
end
