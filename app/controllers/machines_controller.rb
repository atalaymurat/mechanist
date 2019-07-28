class MachinesController < ApplicationController
  before_action :set_machine, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! 

  # GET /machines
  # GET /machines.json
  def index
    @machines = Machine.all
  end

  # GET /machines/1
  # GET /machines/1.json
  def show
    @pictures = @machine.pictures.all
  end

  # GET /machines/new
  def new
    @machine = Machine.new
    @picture = @machine.pictures.build
  end

  # GET /machines/1/edit
  def edit
    @picture = @machine.pictures.build
  end

  # POST /machines
  # POST /machines.json
  def create
    @machine = Machine.new(machine_params)

    respond_to do |format|
      if @machine.save
        if params[:pictures] != nil
          params[:pictures]["image"].each do |img|
          @picture = @machine.pictures.create!(:image => img, :machine_id => @machine.id)
          end
        end
        format.html { redirect_to @machine, notice: 'Machine was successfully created.' }
        format.json { render :show, status: :created, location: @machine }
      else
        format.html { render :new }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /machines/1
  # PATCH/PUT /machines/1.json
  def update
    respond_to do |format|
      if params[:machine][:remove_picture].present?
        params[:machine][:remove_picture].each do |k,v|
          if v.to_i == 1
            @machine.pictures[k.to_i].destroy
          end
        end

      end
        if params[:pictures] != nil
          params[:pictures]["image"].each do |img|
          @picture = @machine.pictures.create!(:image => img, :machine_id => @machine.id)
          end
        end

      if @machine.update!(machine_params)
        format.html { redirect_to @machine, notice: 'Machine was successfully updated.' }
        format.json { render :show, status: :ok, location: @machine }
      else
        format.html { render :edit }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /machines/1
  # DELETE /machines/1.json
  def destroy
    @machine.destroy
    respond_to do |format|
      format.html { redirect_to machines_url, notice: 'Machine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_machine
      @machine = Machine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def machine_params
      params.require(:machine).permit(:brand_id, :category_id, :model_type, :model_year, :condition, :price, :published, :user_id, {images: [ ]}, pictures_attributes: [:id, :image, :_destroy, :machine_id ]   )
    end
end
