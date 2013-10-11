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

class Like < ActiveRecord::Base
  belongs_to :verse
  belongs_to :user
  # attr_accessible :title, :body
  
  def self.like_this(verse, user)
    like = self.where(:verse_id => verse.id, :user_id => user.id)
    if like.first
      like.first.destroy
    else
      like.first_or_create
    end
  end

  def self.d?(verse, user)
    self.where(:verse_id => verse.id, :user_id => user.id).first
  end

  def self.s(verse)
    self.where(:verse_id => verse.id).count
  end
end
