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

module ApplicationHelper
  def percent_color(percent)
    if percent<10
      "#d00000"
    elsif percent < 20
      "#c11111"
    elsif percent < 30
      "#8c1a1a"
    elsif percent < 40
      "#3a0a0a"
    elsif percent < 60
      "#000"
    elsif percent < 70
      "#0a3a0a"
    elsif percent < 80
      "#1a8c1a"
    elsif percent < 90
      "#11c111"
    else
      "#00d000"
    end
  end
end
