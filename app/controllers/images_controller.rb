class ImagesController < ApplicationController
  before_action :set_machine

  def destroy
    remove_image_at_index(params[:id].to_i)
    flash[:error] = "Failed uploading images" unless @machine.save
    redirect_to edit_machine_path(@machine)
  end

  private
  
  def set_machine
    @machine = Machine.find(params[:machine_id])
  end

  def remove_image_at_index(index)
    remain_images = @machine.images
    delete_image = remain_images.delete_at(index)
    @machine.images = remain_images
  end
  
  def images_params
    params.require(:machine).permit(images: [ ])
  end

end
