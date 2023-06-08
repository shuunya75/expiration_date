class FoodsController < ApplicationController
  def index
    @foods = current_user.foods.all
  end
end