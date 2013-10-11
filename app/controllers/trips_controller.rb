#
# Copyright 2008-2013 Concur Technologies, Inc.
# 
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#

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
