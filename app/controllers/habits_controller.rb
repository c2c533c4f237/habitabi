class HabitsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_action :set_habit, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  # GET /habits
  # GET /habits.json
  def index
    @habits = Habit.by_user(current_user)
    @actions = Action.by_user(current_user)
    @values = Value.by_user(current_user)
  end

  # GET /habits/1
  # GET /habits/1.json
  def show
  end

  # GET /habits/new
  def new
    @habit = Habit.new
    @actions = Action.by_user(current_user)
    @values = Value.by_user(current_user)
    @action =  @habit.build_action
    @value = @habit.build_value
  end

  # GET /habits/1/edit
  def edit
  end

  # POST /habits
  # POST /habits.json
  def create
    @habit = Habit.new(habit_params)

    respond_to do |format|
      if HabitFactory.save_habit(@habit)
        format.html { redirect_to @habit, notice: 'Habit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @habit }
      else
        format.html { render action: 'new' }
        format.json { render json: @habit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /habits/1
  # PATCH/PUT /habits/1.json
  def update
    respond_to do |format|
      if @habit.update(habit_params)
        format.html { redirect_to @habit, notice: 'Habit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @habit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /habits/1
  # DELETE /habits/1.json
  def destroy
    @habit.destroy
    respond_to do |format|
      format.html { redirect_to habits_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_habit
      @habit = Habit.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def habit_params
      params.require(:habit).permit(:habit_type, :action_id, :value_id, :user_id, :count, :measurement, :measurement_type, :quantity, :quantity_type, :tags, :description, :time, value_attributes:[:name, :user_id], action_attributes:[:name, :user_id])
    end
end
