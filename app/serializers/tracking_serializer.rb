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