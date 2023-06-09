class Food < ApplicationRecord
  has_one_attached :food_img
  belongs_to :user

  enum management: {賞味期限: 1, 消費期限: 2, 管理しない: 3}

  def food_image
    if food_img.attached?
      food_img
    else
      'no_food.png'
    end
  end
end
