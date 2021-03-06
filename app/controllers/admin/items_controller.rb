class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.page(params[:page]).per(10).reverse_order
    @genres = Genre.where(is_valid: '1')
  end

  def new
    @item = Item.new
    @genres = Genre.where(is_valid: '1')
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.where(is_valid: '1')
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.where(is_valid: '1')
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      render action: :new
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      render action: :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :non_taxed_price, :image, :sale_status, :genre_id)
  end
end
