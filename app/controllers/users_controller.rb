class UsersController < ApplicationController
  def index
    # binding.pry
    # @item = Item.find(params[:item_id])
    @items = Item.limit(10).order('id DESC')
  end

  def show
  end

  def logout
  end

  def edit
    @user  =User.find(params[:id])
  end

end
