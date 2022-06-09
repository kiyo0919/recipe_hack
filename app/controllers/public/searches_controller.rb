class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @word = params[:word]
    search_method = params[:search_method]
    if search_method == "0"
      if Recipe.where('title LIKE ?', '%'+@word+'%').exists? or Ingredient.where(name: @word).exists?
        @recipes = Recipe.where('title LIKE ?', '%'+@word+'%')
        if Ingredient.where(name: @word).exists?
          ingredients = Ingredient.where(name: @word)
          @include_ingredients_recipes = Recipe.where(ingredients: ingredients)
        end
      else
        flash[:alert] = "検索結果が見つかりませんでした"
        redirect_to recipes_path
      end
    elsif search_method == "1"
      if User.where('nick_name LIKE ?', '%'+@word+'%').exists?
        @users = User.where('nick_name LIKE ?', '%'+@word+'%')
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
    else
      flash[:alert] = "#{@tag.name}がつくレシピが見つかりませんでした"
      redirect_to recipes_path
    end
  end
end

