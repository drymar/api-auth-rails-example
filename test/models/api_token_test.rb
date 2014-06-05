require 'test_helper'

class ApiTokenTest < ActiveSupport::TestCase

	test "Creating ApiToken generates new token" do
		api_token = ApiToken.create
		assert_not api_token.token.blank?, "Token was not set"
		assert_match /^[0-9A-F]+$/i, api_token.token, "Token is not a hex string"
	end
	
	test "Regenerate token by setting to nil" do
		api_token = ApiToken.create
		first_token = api_token.token
		api_token.token = nil
		api_token.save
		second_token = api_token.token
		assert_not_equal second_token, nil, "Token was not regenerated"
		assert_not_equal first_token, second_token, "Regenerated token was not different"
	end

	test "User can create new token and be recalled with token" do
		user = User.new(email: 'test@test.com', password: 'test', password_confirmation: 'test')
		user.save
		token = user.new_token
		assert_match /^[0-9A-F]+$/i, token, "Token is not a hex string"
		
		attempted_user = ApiToken.attempt('XXXXXX')
		assert_not attempted_user, "Bad token did not recalled user"
		
		attempted_user = ApiToken.attempt(token)
		assert_equal user, attempted_user, "Token did not recall user"
	end
	
end
