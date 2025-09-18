module Shipping
  class BaseClient
    require "net/http"
    require "json"

    def get(url, headers = {})
      uri = URI(url)
      res = Net::HTTP.get_response(uri)
      handle_response(res)
    end

    def post(url, params, headers = {})
      uri = URI(url)
      request = Net::HTTP::Post.new(uri)
      request['key'] = headers[:api_key] if headers[:api_key].present?
      request['Content-Type'] = headers[:content_type] || 'application/x-www-form-urlencoded'
      request.body = URI.encode_www_form(params)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      response = http.request(request)
      handle_response(response)
    end

    private

    def handle_response(response)
      case response
      when Net::HTTPSuccess
        begin
          parsed_response = JSON.parse(response.body, symbolize_names: true)
          if parsed_response.present?
            if parsed_response.is_a?(Hash) && parsed_response[:meta].present? && parsed_response[:meta][:status] == 'failed'
              Rails.logger.error("Unhandled response: #{response.body}")
              nil
            else
              parsed_response
            end
          else
            Rails.logger.error("Empty response body: #{response.body}")
            nil
          end
        rescue JSON::ParserError => e
          Rails.logger.error("JSON Parse Error: #{e.message}")
          nil
        end
      when Net::HTTPUnauthorized
        { error: 'Authentication Failed', status: 401 }
      else
        Rails.logger.error("Unhandled response: #{response.body}")
        nil
      end
    end
  end
end