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

class Verse < ActiveRecord::Base
  belongs_to :user
  belongs_to :point
  belongs_to :trip
  has_many :likes
  has_many :locations, :through => :trip
  attr_accessible :caption, :tags, :image, :lat, :long, :trip_id
  has_attached_file :image, :styles => { :medium => "600x600#", :bg => "300x300#", :thumb => "100x100#" }
end
