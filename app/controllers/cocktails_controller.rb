class CocktailsController < ApplicationController
  before_action :set_cocktail, only: [:edit, :update, :show]

  def index
   @cocktails = Cocktail.all
   if params[:search]
     @cocktails = Cocktail.search(params[:search]).order("created_at DESC")
   else
     @cocktails = Cocktail.all.order('created_at DESC')
   end
  end

  def show
  end

  def new # GET /tasks/new
    @cocktail = Cocktail.new
  end

  def create # POST /tasks
    @cocktail = Cocktail.new(cocktail_params)
    # save method returns true when record enters database
    if @cocktail.save
      redirect_to new_cocktail_dose_path(@cocktail)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @cocktail.update(cocktail_params)
    # save method returns true when record enters database
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render 'edit'
    end
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end
end
