class HomeController < ApplicationController
  def index
    redirect_to feed_url
  end

  def feed
    @navbar_tab = :feed
    @verses = Verse.order("created_at DESC")
  end

  def guidebook
    @navbar_tab = :guidebook
  end

  def map
    @navbar_tab = :map
  end

  def tag
    @verses = Verse.where("tags LIKE ?", ["%" + params[:tag] + "%"]).order("created_at DESC")
    render "feed"
  end
end
