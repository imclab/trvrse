class VersesController < ApplicationController
  layout false
  # GET /verses
  # GET /verses.json
  def index
    if not params[:tags].nil?
      @verses = Verse.where("tags LIKE ?", ["%" + params[:tags] + "%"])
    else
      @verses = Verse.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @verses }
    end
  end

  def mine
    @verses = current_user.verses

    respond_to do |format|
      format.html { render 'index', :layout => nil }
      format.json { render json: @verses }
    end
  end

  # GET /verses/1
  # GET /verses/1.json
  def show
    @verse = Verse.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @verse }
    end
  end

  # GET /verses/new
  # GET /verses/new.json
  def new
    @verse = Verse.new

    respond_to do |format|
      format.html
      format.json { render json: @verse }
    end
  end

  # GET /verses/1/edit
  def edit
    @verse = Verse.find(params[:id])
  end

  # POST /verses
  # POST /verses.json
  def create
    @verse = Verse.new(params[:verse])
    @verse.user = current_user
    if @verse.save
      puts "############################"
      puts "PULLING EXIF GEOLOCATION DATA FROM " + @verse.image.to_s
      puts "############################"

      begin
        exif = EXIFR::JPEG.new('public' + @verse.image.to_s.sub(/\?.*$/, ''))
        if exif.gps
          @verse.long = exif.gps.longitude
          @verse.lat = exif.gps.latitude
          @verse.save
        end
      rescue EXIFR::MalformedJPEG
        puts "############### WARNING: MALFORMED JPEG ################"
      end

      render json: @verse, status: :created, location: @verse
    else
      render json: @verse.errors, status: :unprocessable_entity
    end
  end

  # PUT /verses/1
  # PUT /verses/1.json
  def update
    @verse = Verse.find(params[:id])

      if @verse.update_attributes(params[:verse])
        head :no_content
      else
        render json: @verse.errors, status: :unprocessable_entity
      end
  end

  # DELETE /verses/1
  # DELETE /verses/1.json
  def destroy
    @verse = Verse.find(params[:id])
    @verse.destroy

    respond_to do |format|
      format.html { redirect_to verses_url }
      format.json { head :no_content }
    end
  end
end
