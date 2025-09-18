module Api
  module V1
    class TrackingsController < Api::V1::BaseController
      def show
        client = Shipping::JneClient.new
        data = client.track(params[:awb])

        render json: TrackingSerializer.new(data).as_json
      end
    end
  end
end