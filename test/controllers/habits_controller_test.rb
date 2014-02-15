require 'test_helper'

class HabitsControllerTest < ActionController::TestCase
  setup do
    @habit = habits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:habits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create habit" do
    assert_difference('Habit.count') do
      post :create, habit: { action: @habit.action, count: @habit.count, description: @habit.description, measurement: @habit.measurement, measurement_type: @habit.measurement_type, object: @habit.object, quantity: @habit.quantity, quantity_type: @habit.quantity_type, tags: @habit.tags, time: @habit.time, type: @habit.type }
    end

    assert_redirected_to habit_path(assigns(:habit))
  end

  test "should show habit" do
    get :show, id: @habit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @habit
    assert_response :success
  end

  test "should update habit" do
    patch :update, id: @habit, habit: { action: @habit.action, count: @habit.count, description: @habit.description, measurement: @habit.measurement, measurement_type: @habit.measurement_type, object: @habit.object, quantity: @habit.quantity, quantity_type: @habit.quantity_type, tags: @habit.tags, time: @habit.time, type: @habit.type }
    assert_redirected_to habit_path(assigns(:habit))
  end

  test "should destroy habit" do
    assert_difference('Habit.count', -1) do
      delete :destroy, id: @habit
    end

    assert_redirected_to habits_path
  end
end
