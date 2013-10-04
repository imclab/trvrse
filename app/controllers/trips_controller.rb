class TripsController < ApplicationController
  def index
    render :json => Trip.where(:user_id => current_user.id).includes(:location).to_json(:include => :location)
  end

  def show
    @trip = Trip.find(params[:id])
    @comment = @trip.comment

    render :layout => false
  end

  def comment
    @trip = Trip.find(params[:id])
    @comment = @trip.comment
    if @comment.nil?
      @comment = Comment.new
    end
    render :layout => false
  end

  def sync
    if not current_user
      render :json => {:nothing => true} and return
    end

    xml = current_user.api.list.trip({'past' => 'true'})
    puts xml.to_s
    xml.elements.each('Response/Trip') do |trip|
      puts trip
      puts "-------------------------"
      puts trip.class
      puts trip.elements['id'].text
      t = Trip.where({:tripit_id => trip.elements['id'].text}).first_or_create()
      t.name = trip.elements['display_name'].text
      t.user = current_user
      t.image_url = trip.elements['image_url'].text
      t.start_date = trip.elements['start_date'].text
      t.end_date = trip.elements['end_date'].text

      # only save if the trip has a location
      if trip.elements['primary_location']
        l = Location.where(:name => trip.elements['primary_location'].text).first_or_create(
          :lat => trip.elements['PrimaryLocationAddress'].elements['latitude'].text,
          :long => trip.elements['PrimaryLocationAddress'].elements['longitude'].text
        )
        l.save

        t.location = l
        t.save
      end
    end

    render :json => {:nothing => true}
  end

end
