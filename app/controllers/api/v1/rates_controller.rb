module Api
  module V1
    class RatesController < Api::V1::BaseController
      def index
        client = Shipping::JneClient.new
        data = client.check_rate(params[:origin], params[:destination], params[:weight])

        if data.present?
          if data[:error]
            render json: {
              success: false,
              error: {
                code: "BAD_REQUEST",
                message: data[:error]
              }
            }, status: data[:status]
          else
            render json: {
              success: true,
              message: "Rates fetched successfully",
              **RateSerializer.new(data).as_json
            }, status: :ok
          end
        else
          render json: {
            success: false,
            error: {
              code: "BAD_REQUEST",
              message: "Invalid request or courier service is unavailable."
            }
          }, status: :bad_request
        end
      rescue StandardError => e
        Rails.logger.info e.message
        render json: {
          success: false,
          error: {
            code: "INTERNAL_ERROR",
            message: "Terjadi kesalahan pada server. Coba lagi nanti"
          }
        }, status: :internal_server_error
      end

      def province
        client = Shipping::JneClient.new
        data = client.check_province

        if data.present?
          if data[:error]
            render json: {
              success: false,
              error: {
                code: "BAD_REQUEST",
                message: data[:error]
              }
            }, status: data[:status]
          else
            render json: {
              success: true,
              message: "Provincies fetched successfully",
              **Jne::ProvinceSerializer.new(data).as_json
            }, status: :ok
          end
        else
          render json: {
            success: false,
            error: {
              code: "BAD_REQUEST",
              message: "Invalid request or courier service is unavailable."
            }
          }, status: :bad_request
        end
      rescue StandardError => e
        Rails.logger.info e.message
        render json: {
          success: false,
          error: {
            code: "INTERNAL_ERROR",
            message: "Terjadi kesalahan pada server. Coba lagi nanti"
          }
        }, status: :internal_server_error
      end

      def city
        client = Shipping::JneClient.new
        data = client.check_city(params[:province_id])

        if data.present?
          if data[:error]
            render json: {
              success: false,
              error: {
                code: "BAD_REQUEST",
                message: data[:error]
              }
            }, status: data[:status]
          else
            render json: {
              success: true,
              message: "Cities fetched successfully",
              **Jne::CitySerializer.new(data).as_json
            }, status: :ok
          end
        else
          render json: {
            success: false,
            error: {
              code: "BAD_REQUEST",
              message: "Invalid request or courier service is unavailable."
            }
          }, status: :bad_request
        end
      rescue StandardError => e
        Rails.logger.info e.message
        render json: {
          success: false,
          error: {
            code: "INTERNAL_ERROR",
            message: "Terjadi kesalahan pada server. Coba lagi nanti"
          }
        }, status: :internal_server_error
      end

      def district
        client = Shipping::JneClient.new
        data = client.check_district(params[:city_id])

        if data.present?
          if data[:error]
            render json: {
              success: false,
              error: {
                code: "BAD_REQUEST",
                message: data[:error]
              }
            }, status: data[:status]
          else
            render json: {
              success: true,
              message: "Districts fetched successfully",
              **Jne::DistrictSerializer.new(data).as_json
            }, status: :ok
          end
        else
          render json: {
            success: false,
            error: {
              code: "BAD_REQUEST",
              message: "Invalid request or courier service is unavailable."
            }
          }, status: :bad_request
        end
      rescue StandardError => e
        Rails.logger.info e.message
        render json: {
          success: false,
          error: {
            code: "INTERNAL_ERROR",
            message: "Terjadi kesalahan pada server. Coba lagi nanti"
          }
        }, status: :internal_server_error
      end

      def sub_district
        client = Shipping::JneClient.new
        data = client.check_sub_district(params[:district_id])

        if data.present?
          if data[:error]
            render json: {
              success: false,
              error: {
                code: "BAD_REQUEST",
                message: data[:error]
              }
            }, status: data[:status]
          else
            render json: {
              success: true,
              message: "Sub-districts fetched successfully",
              **Jne::SubDistrictSerializer.new(data).as_json
            }, status: :ok
          end
        else
          render json: {
            success: false,
            error: {
              code: "BAD_REQUEST",
              message: "Invalid request or courier service is unavailable."
            }
          }, status: :bad_request
        end
      rescue StandardError => e
        Rails.logger.info e.message
        render json: {
          success: false,
          error: {
            code: "INTERNAL_ERROR",
            message: "Terjadi kesalahan pada server. Coba lagi nanti"
          }
        }, status: :internal_server_error
      end
    end
  end
end
