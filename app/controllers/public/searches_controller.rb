class Public::SearchesController < ApplicationController
  def search
    @word = params[:word]
    if Recipe.where('title LIKE ?', '%'+@word+'%').exists? or Ingredient.where(name: @word).exists?
      @recipes = Recipe.where('title LIKE ?', '%'+@word+'%')
      if Ingredient.where(name: @word).exists?
        ingredients = Ingredient.where(name: @word)
        include_ingredients_recipe = Recipe.where(ingredients: ingredients)
        @recipes += include_ingredients_recipe
      end
    elsif User.where('nick_name LIKE ?', '%'+@word+'%').exists?
      @users = User.where('nick_name LIKE ?', '%'+@word+'%')
    end
  end
end
