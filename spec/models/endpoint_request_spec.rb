require 'rails_helper'

RSpec.describe EndpointRequest, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: endpoint_requests
#
#  id         :integer          not null, primary key
#  url        :string
#  params     :jsonb
#  response   :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
