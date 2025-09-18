# Step 1: Buat Controller Dasar
# app/controllers/rates_controller.rb
class RatesController < ApplicationController
  def index
    # misal default courier: JNE
    client = Shipping::JneClient.new
    data = client.check_rate(params[:origin], params[:destination], params[:weight])

    render json: RateSerializer.new(data).as_json
  end
end

# app/controllers/trackings_controller.rb
class TrackingsController < ApplicationController
  def show
    client = Shipping::JneClient.new
    data = client.track(params[:awb])

    render json: TrackingSerializer.new(data).as_json
  end
end

# 🎯 Step 2: Service Objects (Integrasi API)
# app/services/shipping/base_client.rb
module Shipping
  class BaseClient
    require "net/http"
    require "json"

    def get(url, headers = {})
      uri = URI(url)
      res = Net::HTTP.get_response(uri)
      JSON.parse(res.body, symbolize_names: true)
    end
  end
end

# app/services/shipping/jne_client.rb
module Shipping
  class JneClient < BaseClient
    BASE_URL = "https://apijne.example.com"

    def check_rate(origin, destination, weight)
      # ini contoh dummy, nanti sesuaikan format API JNE benerannya
      get("#{BASE_URL}/rates?origin=#{origin}&dest=#{destination}&weight=#{weight}")
    end

    def track(awb)
      get("#{BASE_URL}/tracking?awb=#{awb}")
    end
  end
end

# 🎯 Step 3: Serializer (Biar output rapi)
# app/serializers/rate_serializer.rb
class RateSerializer
  def initialize(data)
    @data = data
  end

  def as_json
    {
      courier: "JNE",
      price: @data[:price],
      etd: @data[:etd]
    }
  end
end

# app/serializers/tracking_serializer.rb
class TrackingSerializer
  def initialize(data)
    @data = data
  end

  def as_json
    {
      courier: "JNE",
      awb: @data[:awb],
      status: @data[:status],
      history: @data[:history]
    }
  end
end

# 🎯 Step 4: Routes
Rails.application.routes.draw do
  root "home#index"

  resources :rates, only: [:index]
  resources :trackings, only: [:show]
end

# 🎯 Step 5: Simple View
# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
  end
end

<!-- app/views/home/index.html.erb -->
<h1>Shipping Service</h1>
<p>Cek ongkir & tracking paket.</p>
