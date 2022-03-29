class Public::RecipesController < ApplicationController

  def new
    @recipe = Recipe.new
    @ingredients = @recipe.ingredients.build
    @steps = @recipe.steps.build
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_comment = RecipeComment.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      flash[:notice] = "レシピを登録しました"
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    if @recipe.user_id == current_user.id
      render :edit
    else
      redirect_to recipe_path(@recipe)
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.user_id == current_user.id
      @recipe.update(recipe_params)
      flash[:notice] = "レシピを更新しました"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :image, :catch_phrase, :number_of_persons, :tip, :background,
                                    :genre_id, ingredients_attributes: [:id, :name, :quantity, :_destroy],
                                    steps_attributes: [:id, :step_image, :step, :description, :_destroy])
  end
end
