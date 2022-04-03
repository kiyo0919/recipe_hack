class Public::SearchesController < ApplicationController
  def search
    @word = params[:word]
    search_method = params[:search_method]
    if search_method == "0"
      if Recipe.where('title LIKE ?', '%'+@word+'%').exists? or Ingredient.where(name: @word).exists?
        @recipes = Recipe.where('title LIKE ?', '%'+@word+'%')
        if Ingredient.where(name: @word).exists?
          ingredients = Ingredient.where(name: @word)
          include_ingredients_recipes = Recipe.where(ingredients: ingredients)
          @recipes = include_ingredients_recipes
          if Recipe.where(title: @word)
            recipe = Recipe.where(title: @word)
            @recipes += recipe
          end
        end
      elsif User.where('nick_name LIKE ?', '%'+@word+'%').exists?
        @users = User.where('nick_name LIKE ?', '%'+@word+'%')
      else
        flash[:alert] = "検索結果が見つかりませんでした"
        redirect_to recipes_path
      end
    elsif search_method == "1"
      if current_user.recipes.where('title LIKE ?', '%'+@word+'%').exists? or Ingredient.where(name: @word).exists?
        @recipes = current_user.recipes.where('title LIKE ?', '%'+@word+'%')
        if current_user.ingredients.where(name: @word).exists?
          ingredients = current_user.ingredients.where(name: @word)
          include_ingredients_current_user_recipes = current_user.recipes.where(ingredients: ingredients)
          @recipes = include_ingredients_current_user_recipes
          if current_user.recipes.where(title: @word)
            recipe = current_user.recipes.where(title: @word)
            @recipes += recipe
          end
        end
      else
        flash[:alert] = "検索結果が見つかりませんでした"
        redirect_to recipes_path
      end
    end
  end

  def tag_search
    if Tag.find(params[:tag_id]).present?
      @tag = Tag.find(params[:tag_id])
      @recipes = @tag.recipes
    end
  end
end

