class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes
    @stock_food = StockFood.new
    @stock_foods = current_user.stock_foods
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
      render :edit
    else
      redirect_to user_path(@user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.id == current_user.id
      @user.update(user_params)
      flash[:notice] = "プロフィール情報を更新しました"
      redirect_to user_path(@user)
    else
      redirect_to user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :nick_name, :first_name_kana,
      :postal_code, :phone_number, :address, :birth_date, :email, :profile_image)
  end
end
