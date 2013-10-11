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

class User < ActiveRecord::Base
  attr_accessible :authorized_key, :authorized_secret, :tripit_ref, :email
  has_many :trips
  has_many :comments
  has_many :verses
  has_many :likes

  validates_uniqueness_of :tripit_ref

  def api
    if @api
      return @api
    else
      trippy = Trippy.new(TRIPIT_KEY, TRIPIT_SECRET)
      trippy.authorized_token = authorized_key
      trippy.authorized_secret = authorized_secret
      @api = trippy.api
      return @api
    end
  end

  def name
    tripit_ref
  end

  def gravatar(size = 16)
    gravatar_id = Digest::MD5.hexdigest((email || 'noemail').downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size.to_s}&d=retro"
  end
end
