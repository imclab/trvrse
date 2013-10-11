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

class HomeController < ApplicationController
  def index
    redirect_to feed_url
  end

  def feed
    @navbar_tab = :feed
    @verses = Verse.order("created_at DESC")
  end

  def guidebook
    @navbar_tab = :guidebook
  end

  def map
    @navbar_tab = :map
  end

  def tag
    @verses = Verse.where("tags LIKE ?", ["%" + params[:tag] + "%"]).order("created_at DESC")
    render "feed"
  end
end
