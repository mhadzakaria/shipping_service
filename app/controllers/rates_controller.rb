class RatesController < ApplicationController
  def index
    # misal default courier: JNE
    client = Shipping::JneClient.new
    data = client.check_rate(params[:origin], params[:destination], params[:weight])

    if data.present?
      render json: RateSerializer.new(data).as_json
    else
      render json: {
        meta: {
          status: 'failed',
          message: 'Invalid request or courier service is unavailable.'
        },
        data: nil
      }, status: :bad_request
    end
  rescue StandardError => e
    render json: {
      meta: {
        status: 'failed',
        message: e.message
      },
      data: nil
    }, status: :internal_server_error
  end
end