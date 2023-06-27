class FoodsController < ApplicationController
  before_action :authenticate_user!
  def index
    @foods = current_user.foods.all
  end

  def new
    @food = current_user.foods.build
  end

  def create
    @food = current_user.foods.build(food_params)
    if @food.save
      redirect_to root_path(@food), notice: '保存できました'
    else
      flash.now[:error] = '保存できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @food = current_user.foods.find(params[:id])
  end

  def update
    @food = current_user.foods.find(params[:id])

    if params[:food][:remove_food] == "1"
      @food.food_image.purge
    end

    if @food.update(food_params)
      redirect_to root_path, notice: '更新されました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    food = current_user.foods.find(params[:id])
    food.destroy!
    redirect_to root_path, notice: '削除に成功しました'
  end

  private
  def food_params
    params.require(:food).permit(:food_img, :name, :content, :management, :limit, :count)
  end
end