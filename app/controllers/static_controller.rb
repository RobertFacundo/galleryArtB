class StaticController < ApplicationController
  skip_before_action :authentication_request!, only: [:index]
  
  def index
  end
end
