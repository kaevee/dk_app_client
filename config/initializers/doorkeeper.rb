require 'omniauth-oauth2'

module OmniAuth
	module Strategies
		class Doorkeeper < OmniAuth::Strategies::OAuth2
			# change the class name and the :name option to match your application name
			option :name, :doorkeeper

			option :client_options, {
				:site => "http://lvh.me:5000",
				:authorize_url => "/oauth/authorize"
			}

			uid { raw_info["id"] }

			info do
				{
					:email => raw_info["email"]
					# and anything else you want to return to your API consumers
				}
			end

			def raw_info
				@raw_info ||= access_token.get('/me.json').parsed
			end

			# https://github.com/intridea/omniauth-oauth2/issues/81
			def callback_url
				full_host + script_name + callback_path
			end
		end
	end
end
