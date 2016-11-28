module Backoffice
  class ApplicationController < ActionController::Base
    layout 'backoffice'
    include Concerns::Authentication

    protect_from_forgery with: :exception

    before_action :authenticate!
  end
end
