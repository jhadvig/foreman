require 'test_helper'

class Api::V2::SmartProxiesControllerTest < ActionController::testCase

	# def setup
 #    	ProxyAPI::Puppet.any_instance.stubs(:environments).returns(["foreman-testing"])
 #    	ProxyAPI::Puppet.any_instance.stubs(:classes).returns(mocked_classes)
 #  	end
 	test "should import environemnts with puppet classes" do
 		get :import_all_environments, { :id => smart_proxies(:one).to_param }
 		assert_response :success
 		assert_not_nil assigns(:importer)
 		environment_classes = ActiveSupport::JSON.decode(@response.body)
 		assert !environment_classes.empty?
 	end


end