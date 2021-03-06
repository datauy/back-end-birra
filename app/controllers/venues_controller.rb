class VenuesController < AdminController
  before_action :set_venue, only: [:edit, :update, :destroy]

  def index
    @venues = Venue.all
    @venue = Venue.new
    @beers = Beer.all.includes(:brewery).order('breweries.name')
  end

  def edit
    @beers = Beer.all.includes(:brewery).order('breweries.name')
  end

  def create
    @venue = Venue.new(venue_params)

    respond_to do |format|
      if @venue.save
        format.html { redirect_to venues_url, notice: 'Venue was successfully created.' }
      else
        format.html do
          @venues = Venue.all
          render :index
       end
      end
    end
  end

  def update
    respond_to do |format|
      if @venue.update(venue_params)
        format.html { redirect_to edit_venue_url(@venue), notice: 'Venue was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @venue.destroy
    respond_to do |format|
      format.html { redirect_to venues_url, notice: 'Venue was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_venue
    @venue = Venue.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def venue_params
    params.require(:venue).permit(:name, :venue_type, :email, :foursquare_id, beer_ids: [])
  end
end
