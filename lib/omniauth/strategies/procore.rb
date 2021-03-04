require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Procore < OmniAuth::Strategies::OAuth2
      option :name, 'procore'

      option(
        :client_options,
        site: 'https://login.procore.com',
        api_site: 'https://api.procore.com',
        authorize_path: '/oauth/authorize',
        version: 'v1.0'
      )

      uid do
        raw_info['id']
      end

      info do
        {
          email: raw_info['login'],
          name: raw_info['name'],
          procore_id: raw_info['id']
        }
      end

      def raw_info
        access_token.client.site = options[:client_options][:api_site]
        version = options[:client_options][:version]
        path = /\Av\d+\.\d+\z/.match?(version) ? "/rest/#{version}" : "/#{version}"
        @raw_info ||= access_token.get("#{path}/me").parsed
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
