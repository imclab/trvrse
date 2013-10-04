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
