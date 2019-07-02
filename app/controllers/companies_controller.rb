class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! 
  respond_to :html, :json
  
  @position_titles = ["Owner", "Manager", "Sales Dep", "Technical Dep.", "Shareholder" ]
  def import
    if params[:file].present?
      if Company.import(params[:file])
        redirect_to import_companies_path
        flash[:notice] = "Data from CSV file imported"
      else
        redirect_to import_companies_path
        flash[:error] = "There is a problem with your data" 
      end
    end
  end
  
  def index
    # @companies = Company.all.order(:id)
    if params[:page]
      session[:company_index_page] = params[:page]
    end
    @companies = policy_scope(Company).order(:id).page(session[:company_index_page])
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

    flash[:notice] = "Company was successfully created." if @company.save
    respond_with(@company)
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    if logo_params[:remove_logo] == "1"
      @company.remove_logo!
      @company.save
    end  

    flash[:notice] = "Company was successfully updated." if @company.update(company_params)
    respond_with(@company)
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    flash[:notice] = "Company was successfully destroyed."
    respond_with(@company)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
      authorize @company
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name,
                                      :email,
                                      :url,
                                      :logo,
                                      :remote_logo_url,
                                      :address_title, :country_id, :state_id, :town, :zip,:address_line,
                                      :note,
                                      :source,
                                      :invoice_title,
                                      people_attributes:[ :first_name,
                                                          :middle_name,
                                                          :last_name,
                                                          :_destroy,
                                                          :id,
                                                          :user_id,
                                                          emails_attributes: [:email,
                                                                              :id,
                                                                              :user_id
                                                                              ],
                                                          phones_attributes: [:id,
                                                                              :phone_type,
                                                                              :phone_number
                                                                              ]
                                                        ],
                                    connected_attributes: [:person_id, 
                                                           :position, 
                                                           :id, 
                                                           :_destroy
                                                        ]
                                     )
    end
    
    def logo_params
      params.require(:company).permit(:remove_logo)
    end

end
