require 'test_helper'
class Quip::Admin::QuipAppsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @quip_admin_quip_app = create quip_admin_quip_apps
  end

  test 'index ok' do
    get admin_quip_apps_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_quip_app_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('QuipApp.count') do
      post admin_quip_apps_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_quip_app_url(@quip_admin_quip_app)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_quip_app_url(@quip_admin_quip_app)
    assert_response :success
  end

  test 'update ok' do
    patch admin_quip_app_url(@quip_admin_quip_app), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('QuipApp.count', -1) do
      delete admin_quip_app_url(@quip_admin_quip_app)
    end

    assert_response :success
  end

end
