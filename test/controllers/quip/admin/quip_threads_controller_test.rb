require 'test_helper'
class Quip::Admin::QuipThreadsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @quip_admin_quip_thread = create quip_admin_quip_threads
  end

  test 'index ok' do
    get admin_quip_threads_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_quip_thread_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('QuipThread.count') do
      post admin_quip_threads_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_response :success
  end

  test 'show ok' do
    get admin_quip_thread_url(@quip_admin_quip_thread)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_quip_thread_url(@quip_admin_quip_thread)
    assert_response :success
  end

  test 'update ok' do
    patch admin_quip_thread_url(@quip_admin_quip_thread), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('QuipThread.count', -1) do
      delete admin_quip_thread_url(@quip_admin_quip_thread)
    end

    assert_response :success
  end

end
