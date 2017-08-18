class CocktailsController < ApplicationController
  def index
   @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
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
    @cocktail = Cocktail.find(params[:id])
  end

  def update
    @cocktail = Cocktail.find(params[:id])
    @cocktail.update(cocktail_params)
    # save method returns true when record enters database
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render 'edit'
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end
end
