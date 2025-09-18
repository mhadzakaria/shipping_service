module Shipping
  class JneClient < BaseClient
    BASE_URL = "https://rajaongkir.komerce.id/api/v1/calculate/district/domestic-cost"
    API_KEY = ENV['RAJA_ONGKIR_SHIPPING_COST_API_KEY']

    def check_rate(origin, destination, weight)
      params = {
        origin: origin,
        destination: destination,
        weight: weight,
        courier: 'jne',
        price: 'lowest'
      }

      headers = {
        api_key: API_KEY,
        content_type: 'application/x-www-form-urlencoded'
      }

      response = post(BASE_URL, params, headers)

      if response.present?
        # Timestamp
        timestamp = Time.now.strftime("%Y%m%d%H%M%S")

        # Nama file di public/
        filename = "public/rate_#{origin}_#{destination}_#{weight}_#{params[:courier]}_#{params[:price]}_#{timestamp}.json"

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

    def track(awb)
      # Bisa implement nanti
      {}
    end
  end
end
