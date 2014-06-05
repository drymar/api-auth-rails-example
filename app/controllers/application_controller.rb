class ApplicationController < ActionController::Base

	protected

		def authenticate
			authenticate_credentials || authenticate_token || render_unauthorized
		end

		def authenticate_token
			authenticate_with_http_token do |token, options|
				@current_user = ApiToken.attempt(token)
			end
		end

		def authenticate_credentials
			if params.has_key?(:credentials) && params[:credentials].has_key?(:email) && params[:credentials].has_key?(:password)
				@current_user = User.find_by(email: params[:credentials][:email]).try(:authenticate, params[:credentials][:password])
			else
				false
			end
		end

		def render_unauthorized
			self.headers['WWW-Authenticate'] = 'Token realm="Application"'
			render json: 'Bad credentials', status: 401
		end
end