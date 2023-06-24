class Profile < ApplicationRecord
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
