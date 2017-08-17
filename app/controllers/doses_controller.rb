class DosesController < ApplicationController
  def new
    # we need @restaurant in our `simple_form_for`
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end

  # inside create we need the same instances as in new
  #  so we need an @restaurant and a @review
  def create
    # set a new empty dose
    @dose = Dose.new(dose_params)
    # find the cocktail the dose is for
    @cocktail = Cocktail.find(params[:cocktail_id])
    # assign newly dose to this cocktail: ASSOCIATION
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy # DELETE /doses/:id
    @dose = Dose.find(params[:id])
    @dose.destroy
    # no need for app/views/tasks/destroy.html.erb
    redirect_to cocktails_path
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :cocktail_id, :ingredient_id)
    #  Here the params need to be just like in the schema
  end
end
