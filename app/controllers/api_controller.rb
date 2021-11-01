class ApiController < ApplicationController

  private
  def set_default_format
    request.format = :json
  end
end
