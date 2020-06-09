class ApplicationController < ActionController::API
  def generate_error(title:, detail:, parameter:, status: 400)
    ErrorSerializer.new(detail: detail,
                        title: title,
                        status: status,
                        pointer: request.env['PATH_INFO'],
                        parameter: parameter).errors
  end
end
