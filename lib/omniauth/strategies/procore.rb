require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Procore < OmniAuth::Strategies::OAuth2
      option :name, 'procore'

      option :client_options,
             site: 'https://login.procore.com',
             api_site: 'https://api.procore.com',
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
        @raw_info ||=
          if options.client_options.site == options.client_options.api_site
            # This is the sandbox case where we use sandbox.procore.com
            # for both authentication and the api
            access_token.get('/vapid/me').parsed
          else
            # This is the production case where we have separate subdomains
            # for authentication and for the api
            api_get('/vapid/me')
          end
      end

      def callback_url
        full_host + script_name + callback_path
      end

      private

      # @param [String] path of the api endpoint
      # @return [Hash] the response json body parsed into a hash
      def api_get(path)
        uri = URI.parse("#{options.client_options.api_site}#{path}")
        request = Net::HTTP::Get.new(uri)
        request["authorization"] = "Bearer #{access_token.token}"
        response = Net::HTTP.start(request.uri.hostname, request.uri.port, use_ssl: true) do |http|
          http.request(request)
        end
        if response.kind_of? Net::HTTPSuccess
          JSON.parse(response.body)
        else
          raise "Error talking to Procore: #{response.message} (code = #{response.code}, uri = #{response.uri})"
        end
      end

    end
  end
end
