class ConnectedsController < ApplicationController
  def destroy
    @connected = Connected.find(params[:id])
    @connected.destroy
    @company = @connected.company_id
    flash[:notice] = "Connection was successfully removed."
    redirect_to company_path(@company)
  end
end
