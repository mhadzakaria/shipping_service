class RateSerializer
  def initialize(data)
    @data = data
  end

  def as_json
    {
      courier: "JNE",
      rates: @data[:data]
    }
  end
end