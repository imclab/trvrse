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

class List < ActiveRecord::Base
  belongs_to :user
  has_many :list_items
  has_many :locations, :through => :list_items
  attr_accessible :description, :to_what

  def name(short = false)
    if short
      "The #{list_items.count} best places to #{to_what}"
    else
      "The #{list_items.count} best places in the world to #{to_what}"
    end
  end
end
