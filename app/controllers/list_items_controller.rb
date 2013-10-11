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

class ListItemsController < ApplicationController
  layout false
  before_filter :get_list

  # GET /list_items/1
  # GET /list_items/1.json
  def show
    @list_item = @list.list_items.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @list_item }
    end
  end

  # GET /list_items/new
  # GET /list_items/new.json
  def new
    @list_item = @list.list_items.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @list_item }
    end
  end

  # GET /list_items/1/edit
  def edit
    @list_item = @list.list_items.find(params[:id])
  end

  # POST /list_items
  # POST /list_items.json
  def create
    @list_item = @list.list_items.new(params[:list_item])
    location = Location.where(:name => params[:location_name]).first

    # if it's nil, we don't have a location for this place yet. Either create it from place table data, or if we don't know where it is, throw an error
    if location.nil?
      place = Place.where(:display_name => params[:location_name]).first
      if place.nil?
        head :bad_request
        return
      end
      location = Location.create(name: place.display_name, lat: place.latitude, long: place.longitude)
    end

    @list_item.location = location

    respond_to do |format|
      if @list_item.save
        format.html { redirect_to @list_item, notice: 'List item was successfully created.' }
        format.json { render json: @list_item, status: :created }
      else
        format.html { render action: "new" }
        format.json { render json: @list_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /list_items/1
  # PUT /list_items/1.json
  def update
    @list_item = @list.list_items.find(params[:id])
    location = Location.where(:name => params[:location_name]).first

    # if it's nil, we don't have a location for this place yet. Either create it from place table data, or if we don't know where it is, throw an error
    if location.nil?
      place = Place.where(:display_name => params[:location_name]).first
      if place.nil?
        head :bad_request
        return
      end
      location = Location.create(name: place.display_name, lat: place.latitude, long: place.longitude)
    end

    @list_item.location = location
    respond_to do |format|
      if @list_item.update_attributes(params[:list_item])
        format.html { redirect_to @list_item, notice: 'List item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @list_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /list_items/1
  # DELETE /list_items/1.json
  def destroy
    @list_item = @list.list_items.find(params[:id])
    @list_item.destroy

    respond_to do |format|
      format.html { redirect_to list_items_url }
      format.json { head :no_content }
    end
  end

  private
    def get_list
      @list = List.find(params[:list_id])
    end
end
