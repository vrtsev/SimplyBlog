require 'test_helper'

class WarningsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @warning = warnings(:one)
  end

  test "should get index" do
    get warnings_url
    assert_response :success
  end

  test "should get new" do
    get new_warning_url
    assert_response :success
  end

  test "should create warning" do
    assert_difference('Warning.count') do
      post warnings_url, params: { warning: { content: @warning.content, title: @warning.title } }
    end

    assert_redirected_to warning_url(Warning.last)
  end

  test "should show warning" do
    get warning_url(@warning)
    assert_response :success
  end

  test "should get edit" do
    get edit_warning_url(@warning)
    assert_response :success
  end

  test "should update warning" do
    patch warning_url(@warning), params: { warning: { content: @warning.content, title: @warning.title } }
    assert_redirected_to warning_url(@warning)
  end

  test "should destroy warning" do
    assert_difference('Warning.count', -1) do
      delete warning_url(@warning)
    end

    assert_redirected_to warnings_url
  end
end
