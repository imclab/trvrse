class UsersController < ApplicationController
  def show
    @user = User.where(:tripit_ref => params[:username]).first
    if @user == nil
      raise ActionController::RoutingError.new('Not Found')
    end

    if @user == current_user
      @navbar_tab = :user
    end

    @verses = @user.verses.order('created_at DESC')
  end
end
