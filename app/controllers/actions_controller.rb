class ActionsController < ApplicationController
  before_action :set_action, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /actions
  # GET /actions.json
  def index
    @actions = Action.all
  end

  # GET /actions/1
  # GET /actions/1.json
  def show
  end

  # GET /actions/new
  def new
    @action = Action.new
  end

  # GET /actions/1/edit
  def edit
  end

  # POST /actions
  # POST /actions.json
  def create
    @action = Action.new(action_params)

    respond_to do |format|
      if @action.save
        format.html { redirect_to @action, notice: 'Actions was successfully created.' }
        format.json { render action: 'show', status: :created, location: @action }
      else
        format.html { render action: 'new' }
        format.json { render json: @action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /actions/1
  # PATCH/PUT /actions/1.json
  def update
    respond_to do |format|
      if @action.update(action_params)
        format.html { redirect_to @action, notice: 'Actions was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actions/1
  # DELETE /actions/1.json
  def destroy
    @action.destroy
    respond_to do |format|
      format.html { redirect_to actions_index_url }
      format.json { head :no_content }
    end
  end

   def autocomplete_action_name
    @action = Action.select("id, name").where("name LIKE ? AND user_id = ?", "#{params[:name]}%", current_user ).order(:name).limit(10)

    respond_to do |format|
      format.json { render json: @action , :only => [:id, :name] }
    end    
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_action
      @action = Action.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def action_params
      params[:namen]
    end
end
