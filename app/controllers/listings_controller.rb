class ListingsController < ApplicationController
  before_action :load_listing, except: [:new, :create]
  allow_unauthenticated only: [:show]

  def new
    @listing = Listing.new
  end
  
  def create
    @listing = Listing.new(
      listing_params.with_defaults(
        creator: Current.user,
        organization: Current.organization
      )
    )

    if @listing.save
      flash[:success] = t('.success')
      redirect_to listing_path(@listing)
      # redirect_to listing_path(@listing),
      # flash: {success: t('.success')}, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    
  end
  
  def update
    if @listing.update(listing_params)
      redirect_to listing_path(@listing), status: :see_other, flash: {success: t('.success')}
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def show
  
  end
  
  def destroy
    @listing.destroy
    redirect_to root_path, status: :see_other, flash: {success: t('.success')}
  end

  private
    def listing_params
      params.require(:listing).permit(:title, :price)
    end

    def load_listing
      @listing = Listing.find(params[:id])
    end
end
