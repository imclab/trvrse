#!/usr/bin/env ruby

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


class Trippy
  API_URL = "https://api.tripit.com"
  
  @api_key = ""
  @api_secret = ""
  @request_token = nil
  @request_secret = nil
  @authorized_token = nil
  @authorized_secret = nil
  @api = nil
  
  attr_accessor :request_token, :request_secret, :authorized_token, :authorized_secret

  # AUTHENTICATION FUCTIONS #
  ###########################

  def initialize(api_key, api_secret)
    @api_key = api_key
    @api_secret = api_secret
  end

  def auth_url(callback)
    "https://www.tripit.com/oauth/authorize?oauth_token=#{@request_token}&oauth_callback=#{callback}"
  end

  def authorized?
    if @authorized_token and @authorized_secret
      true
    else
      false
    end
  end

  def get_request_token!
    creds = TripIt::OAuthCredential.new(@api_key, @api_secret)
    t = new_api(creds)

    token = t.get_request_token

    @request_token = token.token
    @request_secret = token.token_secret

  end

  def authorize!
    creds = TripIt::OAuthCredential.new(
    @api_key, @api_secret,
    @request_token, @request_secret)

    t = new_api(creds)

    token = t.get_access_token

    @authorized_token = token.token
    @authorized_secret = token.token_secret
  end

  def api
    if not @api
      creds = TripIt::OAuthCredential.new(@api_key, @api_secret, @authorized_token, @authorized_secret)
      @api = new_api(creds)
      return @api
    else
      @api
    end
  end


  private
    def new_api(creds)
      TripIt::API.new(creds, API_URL, true)
    end
end
