class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :check_is_shared, only: [:edit, :update, :destroy]

  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.where(user_id: current_user.id)
    @shares = Share.where(user_id: current_user.id)
    @shares.each {
      |share| @albums += Album.where(id: share.album.id)
    }
  end

  # GET /albums/1
  # GET /albums/1.json
  def show

  end

  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(album_params)
    @album.user_id = current_user.id

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album erfolgreich erstellt.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      user = User.find_by_email(params[:share_email])

      if user != nil
        # Überprüfen, ob Album noch nicht geteilt wurde mit dem User
        if not @album.shares.any? {|share| share.user_id == user.id}
          share = Share.new
          share.album = @album
          share.user = user
          @album.shares << share
        end

      end

      if @album.update(album_params)
        format.html { redirect_to @album, notice: 'Album erfolgreich geändert.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Album erfolgreich gelöscht.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.includes(:photos, :shares).find(params[:id])
    end

  def check_is_shared
    puts @album.user_id
    if @album.user_id != current_user.id
      respond_to do |format|
        format.html { redirect_to albums_url, notice: 'Album gehört nicht dir.' }
        format.json { head :no_content }
      end
    end
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:title, :description, :share_email)
    end
end
