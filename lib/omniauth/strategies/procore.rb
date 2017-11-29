require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Procore < OmniAuth::Strategies::OAuth2
      option :name, 'procore'

      option :client_options,
        site: 'https://app.procore.com',
        authorize_path: '/oauth/authorize'

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
        @raw_info ||= access_token.get('/vapid/me').parsed
      end

      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end
    end
  end
end
