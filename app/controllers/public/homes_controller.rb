class Public::HomesController < ApplicationController
  def top
    @recipes = Recipe.order("RANDOM()").limit(4)
  end

  def about
  end
end
