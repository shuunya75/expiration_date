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

  def limit_day
    limit_day = "#{limit.year - 2000}年#{limit.month}/#{limit.day}"

    if management == '管理しない'
      ''
    else
      limit_day
    end
  end

  def deadline
    years = limit.year - Time.zone.now.year
    days = limit.yday - Time.zone.now.yday

    "#{limit} g #{Time.zone.now}   aaa   #{days + 365}"

    if management == '管理しない'
      ''
    elsif years == 0 && days < 0
      '期限切れ'
    elsif years == 0 && days == 0
      '今日まで'
    elsif years == 0 && days > 0
      "あと#{days}日"
    elsif years < 0
      '期限切れ'
    elsif years == 1 && days < 0
      "あと#{days + 365}日"
    elsif years > 0 && days < 0
      "あと#{years - 1}年#{days + 365}日"
    elsif years > 0 && days == 0
      "あと#{years}年"
    elsif years > 0 && days > 0
      "あと#{years}年と#{days}日"
    end
  end
end
