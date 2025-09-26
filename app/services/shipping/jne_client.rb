module Shipping
  class JneClient < BaseClient
    BASE_URL = "https://rajaongkir.komerce.id/api/v1"
    API_KEY = ENV["RAJA_ONGKIR_SHIPPING_COST_API_KEY"]

    def initialize()
      @endpoint_request = nil
    end

    def check_rate(origin, destination, weight)
      params = {
        origin: origin,
        destination: destination,
        weight: weight,
        courier: "jne",
        price: "lowest"
      }

      headers = {
        api_key: API_KEY,
        content_type: "application/x-www-form-urlencoded"
      }

      response = post("#{BASE_URL}/calculate/district/domestic-cost", params, headers)

      if response.present?
        # Timestamp
        timestamp = Time.now.strftime("%Y%m%d%H%M%S")
        m = Time.now.strftime("%m")
        d = Time.now.strftime("%d")

        # Nama file di public/
        folder_name = "public/#{m}/#{d}/"
        FileUtils.mkdir_p(folder_name) unless Dir.exist?(folder_name)

        filename = "#{folder_name}rate_#{origin}_#{destination}_#{weight}_#{params[:courier]}_#{params[:price]}_#{timestamp}.json"

        # Simpan file JSON
        File.open(filename, "w") do |f|
          f.write({
            timestamp: timestamp,
            params: params,
            response_body: response.to_json
          }.to_json)
        end
      end

      response
    end

    def check_province
      check_province_url = "#{BASE_URL}/destination/province"

      if collect_last_request(url: check_province_url, params: {}).present?
        return @endpoint_request.response.deep_symbolize_keys
      end

      response = get(check_province_url, endpoint_headers)
      save_response_as_record(response, "province", url: check_province_url, params: {})
      response
    end

    def check_city(province_id)
      check_city_url = "#{BASE_URL}/destination/city/#{province_id}"

      if collect_last_request(url: check_city_url, params: {}).present?
        return @endpoint_request.response.deep_symbolize_keys
      end

      response = get(check_city_url, endpoint_headers)
      save_response_as_record(response, "city", url: check_city_url, params: {})
      response
    end

    def check_district(city_id)
      check_district_url = "#{BASE_URL}/destination/district/#{city_id}"

      if collect_last_request(url: check_district_url, params: {}).present?
        return @endpoint_request.response.deep_symbolize_keys
      end

      response = get(check_district_url, endpoint_headers)
      save_response_as_record(response, "district", url: check_district_url, params: {})
      response
    end

    def check_sub_district(district_id)
      check_sub_district_url = "#{BASE_URL}/destination/sub-district/#{district_id}"

      if collect_last_request(url: check_sub_district_url, params: {}).present?
        return @endpoint_request.response.deep_symbolize_keys
      end

      response = get(check_sub_district_url, endpoint_headers)
      save_response_as_record(response, "sub_district", url: check_sub_district_url, params: {})
      response
    end

    private

    def endpoint_headers
      {
        api_key: API_KEY,
        content_type: "application/x-www-form-urlencoded"
      }
    end

    def collect_last_request(url: "", params: {})
      @endpoint_request = ::EndpointRequest.last_24_hours.find_by(url: url, params: params)
    end

    def save_response_as_record(response, endpoint_name, url: nil, params: {})
      @endpoint_request = ::EndpointRequest.create!(
        url: url,
        params: params,
        response: response
      )
    end

    def save_response_as_file_v1(response, endpoint_name)
      return unless response.present?

      # Timestamp
      timestamp = Time.now.strftime("%Y%m%d%H%M%S")
      m = Time.now.strftime("%m")
      d = Time.now.strftime("%d")

      # Nama file di public/
      folder_name = "public/#{m}/#{d}/"
      FileUtils.mkdir_p(folder_name) unless Dir.exist?(folder_name)

      filename = "#{folder_name}#{endpoint_name}_#{timestamp}.json"

      # Simpan file JSON
      File.open(filename, "w") do |f|
        f.write({
          timestamp: timestamp,
          params: {},
          response_body: response.to_json
        }.to_json)
      end
    end
  end
end
