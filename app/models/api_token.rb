class ApiToken < ActiveRecord::Base
	belongs_to :user
	before_save :check_token
	
	def self.attempt(token_string)
		if api_token = self.where(token: token_string).first
			api_token.user
		else
			false
		end
	end
	
	private
	
		def check_token
			token || new_token
		end
		
		def new_token
			begin
				self.token = SecureRandom.hex
			end while self.class.exists?(token: token)
		end
end