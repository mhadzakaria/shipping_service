class TrackingsController < ApplicationController
  def show
    client = Shipping::JneClient.new
    data = client.track(params[:awb])

    render json: TrackingSerializer.new(data).as_json
  end
end