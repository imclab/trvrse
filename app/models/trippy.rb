#!/usr/bin/env ruby

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
