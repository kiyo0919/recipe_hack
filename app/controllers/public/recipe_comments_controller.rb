class Public::RecipeCommentsController < ApplicationController
  
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_comment = RecipeComment.new(recipe_comment_params)
    @recipe_comment.user_id = current_user.id
    @recipe_comment.recipe_id = @recipe.id
    @recipe_comment.save
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_comment = RecipeComment.find_by(id: params[:id], recipe_id: params[:recipe_id])
    if @recipe_comment.user_id == current_user.id
      @recipe_comment.destroy
    else
      redirect_to recipe_path(@recipe)
    end
  end

  private

  def recipe_comment_params
    params.require(:recipe_comment).permit(:comment)
  end
end
