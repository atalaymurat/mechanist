class PicturesController < ApplicationController
  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.create(picture_params)
  end
  
  def destroy
  
  end

  private
  def picture_params
    params.require(:picture).permit(:id, :image, :_destroy)
  end
end
