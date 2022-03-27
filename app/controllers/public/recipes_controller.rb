class Public::RecipesController < ApplicationController

  def new
    @recipe = Recipe.new
    @ingredients = @recipe.ingredients.build
    @steps = @recipe.steps.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      flash[:notice] = ".レシピを登録しました"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :image, :catch_phrase, :number_of_persons, :tip, :background,
                                    :genre_id, ingredients_attributes: [:name, :quantity, :_destroy],
                                    steps_attributes: [:step_image, :step, :description])
  end
end
