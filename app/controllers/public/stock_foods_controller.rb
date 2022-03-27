class Public::StockFoodsController < ApplicationController

  def create
    @stock_food = StockFood.new(stock_food_params)
    @stock_food.user_id = current_user.id
    if @stock_food.save
      flash[:notice] = ".食材を登録しました"
      redirect_to root_path
    else
      @recipes = Recipe.all
      render template: "public/homes/top"
    end
  end

  def destroy

  end

  private
  def stock_food_params
    params.require(:stock_food).permit(:name, :expiration_date)
  end

end
