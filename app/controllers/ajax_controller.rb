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

class AjaxController < ApplicationController
  layout false
  def trips

  end

  def locations
    if params[:tags] == nil or params[:tags].empty?
      locations = Location.all
    else
      # locations = List.where("to_what LIKE ?", "%" + params[:tags] + "%").first.locations.select('locations.id, locations.lat, locations.long')
      locations = Location.joins(:comments).where("content LIKE ?", ['%' + params[:tags] + '%']).group('locations.id')
    end
    locations.each do |l|
      l['visited'] = l.visited?(current_user)
      l['rating'] = l.rating
    end
    render :json => locations
    #render :json => Location.joins(:trips).group('locations.id').where('trips.user_id = ?', current_user.id)
  end

  def location
    if current_user
    @trips = Trip.where({:user_id => current_user.id, :location_id => params[:id]})
    else
      @trips = nil
    end
    @location = Location.find(params[:id])
  end

  def search
    @lists = List.where("to_what LIKE ?", "%" + params[:search] + "%")
  end

  def like
    verse = Verse.find(params[:id])

    if current_user
      Like.like_this(verse, current_user)
    end
    redirect_to verse
  end
end
