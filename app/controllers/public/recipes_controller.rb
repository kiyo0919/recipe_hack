class Public::RecipesController < ApplicationController

  def new
    @recipe = Recipe.new
    # @tag_list = @recipe.tags.pluck(:name).join(',')
    @ingredients = @recipe.ingredients.build
    @steps = @recipe.steps.build
  end

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_comment = RecipeComment.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    tag_list = params[:recipe][:name].split(',')
    if @recipe.save
      @recipe.save_tag(tag_list)
      flash[:notice] = "レシピを登録しました"
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    if @recipe.user_id == current_user.id
      @tag_list = @recipe.tags.pluck(:name).join(',')
      render :edit
    else
      redirect_to recipe_path(@recipe)
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.user_id == current_user.id
      tag_list=params[:recipe][:name].split(',')
      @recipe.update(recipe_params)
      @old_relations = RecipeTag.where(recipe_id: @recipe.id)
      @old_relations.each do |relation|
        relation.delete
      end
      @recipe.save_tag(tag_list)
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
