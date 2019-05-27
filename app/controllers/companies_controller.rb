class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! 
  
  def index
    # @companies = Company.all.order(:id)
    @companies = policy_scope(Company)
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
    @company.people.build
    authorize @company
  end

  # GET /companies/1/edit
  def edit
    @company.people.build
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)
    @company.user = current_user
    authorize @company

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    if logo_params[:remove_logo] == "1"
      @company.remove_logo!
      @company.save
    end  

    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
      authorize @company
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :email, :url, :logo, :remote_logo_url, person_ids: [],  people_attributes:[ :first_name, :middle_name, :last_name, :_destroy, :id, :user_id])
    end
    
    def logo_params
      params.require(:company).permit(:remove_logo)
    end
end
