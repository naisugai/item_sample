class ImagesController < ApplicationController
  before_action :set_image, only: %i[ show edit update destroy ]

  # GET /images or /images.json
  def index
    @item = Item.where(:id => params[:item_id]).first
    @images = @item.images.all
  end

  # GET /images/1 or /images/1.json
  def show
  end

  # GET /images/new
  def new
    @item = Item.where(:id => params[:item_id]).first
    @image = @item.images.build
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images or /images.json
  def create
    @item = Item.where(:id => params[:item_id]).first
    @image = @item.images.build(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to [@item, @image], notice: "Image was successfully created." }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1 or /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to [@item, @image], notice: "Image was successfully updated." }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1 or /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to item_images_url, notice: "Image was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @item = Item.where(:id => params[:item_id]).first
      @image = @item.images.where(:id => params[:id]).first
    end

    # Only allow a list of trusted parameters through.
    def image_params
      params.require(:image).permit(:item_id, :title)
    end
end
