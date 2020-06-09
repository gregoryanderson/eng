class ErrorSerializer
  def initialize(detail:, status:, title:, pointer:, parameter:)
    @detail = detail
    @status = status
    @title = title
    @parameter = parameter
    @pointer = pointer
  end

  def errors
    {
      errors: [
        status: @status.to_s,
        source: { pointer: @pointer, parameter: @parameter },
        title: @title,
        detail: @detail
      ]
    }
  end
end