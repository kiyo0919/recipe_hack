class Public::StockFoodsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    if @user == current_user
      @stock_foods = current_user.stock_foods
      @stock_food = StockFood.new
      render :index
    else
      redirect_to user_path(@user)
    end
    @notifications = current_user.notifications
    @notifications.where(is_checked: false).each do |notification|
      notification.update(is_checked: true)
    end
  end

  def create
    @stock_food = StockFood.new(stock_food_params)
    @stock_food.user_id = current_user.id
    if @stock_food.save
      flash[:notice] = "食材を登録しました"
      redirect_to user_stock_foods_path(@stock_food.user)
    else
      @recipes = Recipe.all
      render template: "public/homes/top"
    end
  end

  def destroy
    @stock_food = StockFood.find(params[:id])
    if @stock_food.user == current_user
      flash[:notice] = "ストック食材を削除しました"
      @stock_food.destroy
      redirect_to user_stock_foods_path(@stock_food.user)
    else
      redirect_to user_path(@stock_food.user)
    end
  end

  private
  def stock_food_params
    params.require(:stock_food).permit(:name, :expiration_date)
  end

end
