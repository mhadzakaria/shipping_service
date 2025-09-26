class CreateEndpointRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :endpoint_requests do |t|
      t.string :url
      t.jsonb :params
      t.jsonb :response

      t.timestamps
    end
  end
end
