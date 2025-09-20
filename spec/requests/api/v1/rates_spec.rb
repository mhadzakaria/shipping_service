require 'swagger_helper'

RSpec.describe 'Api::V1::Rates', type: :request do
  path '/api/v1/rates' do
    get('list rates') do
      tags 'Rates'
      produces 'application/json'
      parameter name: :origin, in: :query, type: :string, description: 'origin sub-district id', required: true
      parameter name: :destination, in: :query, type: :string, description: 'destination sub-district id', required: true
      parameter name: :weight, in: :query, type: :integer, description: 'weight in grams', required: true

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 meta: {
                   type: :object,
                   properties: {
                     status: { type: :string, example: 'success' },
                     message: { type: :string, example: 'Rates fetched successfully' }
                   }
                 },
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       service_code: { type: :string, example: 'REG' },
                       service_name: { type: :string, example: 'Regular' },
                       description: { type: :string, example: 'Layanan Reguler' },
                       cost: { type: :integer, example: 10000 },
                       etd: { type: :string, example: '1-2' },
                       note: { type: :string, example: '' }
                     }
                   }
                 }
               }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(400, 'bad request') do
        schema type: :object,
               properties: {
                 meta: {
                   type: :object,
                   properties: {
                     status: { type: :string, example: 'failed' },
                     message: { type: :string, example: 'Invalid request or courier service is unavailable.' }
                   }
                 },
                 data: { type: :object, nullable: true }
               }
        run_test!
      end

      response(500, 'internal server error') do
        schema type: :object,
               properties: {
                 meta: {
                   type: :object,
                   properties: {
                     status: { type: :string, example: 'failed' },
                     message: { type: :string, example: 'Internal Server Error' }
                   }
                 },
                 data: { type: :object, nullable: true }
               }
        run_test!
      end
    end
  end
end
