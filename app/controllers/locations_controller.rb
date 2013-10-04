class LocationsController < ApplicationController
  def show
    @navbar_tab = :guidebook
    if current_user
      @trips = Trip.where({:user_id => current_user.id, :location_id => params[:id]})
    else
      @trips = nil
    end
    @location = Location.find(params[:id])

  end
end
