class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  respond_to :html, :json
  def index
    # @people = Person.all.order(:id) 
    @people = policy_scope(Person)
    @people.order(:id)
  end

  # GET /people/1
  # GET /people/1.json
  def show
    
  end

  # GET /people/new
  def new
    @person = Person.new
    authorize @person  
  end

  # GET /people/1/edit
  def edit
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
      params.require(:person).permit(:first_name, :middle_name, :last_name, :company_id, :user_id)
    end
end
