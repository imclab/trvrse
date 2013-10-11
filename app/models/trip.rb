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

class Trip < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  has_many :verses
  has_one :comment
  attr_accessible :name, :tripit_id, :image_url, :start_date, :end_date

  def past?(trueval = true, falseval = false)
    if DateTime.now > end_date
      return trueval
    else
      return falseval
    end
  end
end
