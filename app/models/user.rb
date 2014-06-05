class User < ActiveRecord::Base
	has_secure_password
	has_many :api_tokens
	
	def new_token
		# creates a new ApiToken record and returns the token string
		self.api_tokens.create().token
	end
end
