class Public::HomesController < ApplicationController
  def top
    @recipes = Recipe.all
    @stock_food = StockFood.new
  end

  def about
  end
end
