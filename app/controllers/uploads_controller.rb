class UploadsController < ApplicationController
  before_action :set_upload, only: [:show, :update, :destroy]
  before_action :authenticate_user, only: [:update, :destroy, :create]


  # GET uploads/item/:item_id
  def index_item_upload
    uploads = Upload.where(item_id: params[:item_id])
    ids_urls = uploads.map { |upload| upload.url_id }
    render json: ids_urls
  end

  # GET /uploads
  def index
    @uploads = Upload.all
    render json: @uploads
  end

  # GET /uploads/1
  def show
    render json: @upload
  end

  # POST /uploads
  def create
    @upload = Upload.new(upload_params)
    @upload.item_id = params[:item_id]

    if @upload.save
      render json: @upload, status: :created, location: @upload
    else
      render json: @upload.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /uploads/1
  def update
    if @upload.update(upload_params)
      render json: @upload
    else
      render json: @upload.errors, status: :unprocessable_entity
    end
  end

  # DELETE /uploads/1
  def destroy
    @upload.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def upload_params
      params.require(:upload).permit(:title, :file, :item_id)
    end
end
