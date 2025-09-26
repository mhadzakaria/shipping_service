class EndpointRequest < ApplicationRecord
  scope :last_24_hours, -> { where("created_at >= ?", 24.hours.ago) }
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
