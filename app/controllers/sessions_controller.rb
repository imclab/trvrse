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

class SessionsController < ApplicationController
  def create
    t = Trippy.new(TRIPIT_KEY, TRIPIT_SECRET)
    t.get_request_token!

    session[:request_token] = t.request_token
    session[:request_secret] = t.request_secret

    redirect_to(t.auth_url(Tripit::Application.config.oauth_redirect_url))
  end

  def authorize
    t = Trippy.new(TRIPIT_KEY, TRIPIT_SECRET)
    t.request_token = session[:request_token]
    t.request_secret = session[:request_secret]

    t.authorize!

    xml = t.api.get.profile

    username = xml.root.elements['Profile/screen_name'].text

    if not User.where(:tripit_ref => username).exists?
      u = User.new(:tripit_ref => username)
    else
      u = User.where(:tripit_ref => username).first
    end
    u.authorized_key = t.authorized_token
    u.authorized_secret = t.authorized_secret
    u.email = xml.root.elements['Profile/ProfileEmailAddresses/ProfileEmailAddress/address'].text
    u.save

    session[:user_id] = u.id

    redirect_to root_url
  end

  def destroy
    session[:request_token] = nil
    session[:request_secret] = nil
    session[:user_id] = nil
    redirect_to root_url
  end
end
