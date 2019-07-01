class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  respond_to :html, :json

  def import
    if params[:file].present?
      if Person.import(params[:file])
        redirect_to import_people_path
        flash[:notice] = "Data from CSV file imported"
      else
        redirect_to import_people_path
        flash[:error] = "There is a problem with your data"
      end
    end
  end

  def index
    # @people = Person.all.order(:id) 
    @people = policy_scope(Person).page(params[:page])
  end

  # GET /people/1
  # GET /people/1.json
  def show
    
  end

  # GET /people/new
  def new
    @person = Person.new
    @person.emails.build
    @person.phones.build
    authorize @person  
  end

  # GET /people/1/edit
  def edit
    @person.emails.build
    @person.phones.build
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)
    @person.user = current_user
    authorize @person

    flash[:notice] = "Person was successfully created." if @person.save
    respond_with(@person)
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    flash[:notice] = "Person was successfully updated." if @person.update(person_params)
    respond_with(@person)
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    flash[:notice] = "Person was successfully deleted."
    respond_with(@person)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
      authorize @person
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:first_name, :middle_name, :last_name,
                                     :company_id,
                                     :user_id,
                                     :note,
                                     :source,
                                     emails_attributes:[ :id, :email, :_destroy, :user_id ],
                                     phones_attributes: [:id, :phone_type, :phone_number, :_destroy]
                                    )
    end
end
