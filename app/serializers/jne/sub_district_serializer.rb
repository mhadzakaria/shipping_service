class Jne::SubDistrictSerializer
  def initialize(data)
    @data = data
  end

  def as_json
    {
      courier: "JNE",
      data: @data[:data]
    }
  end
end
