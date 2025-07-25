class StaticController < ApplicationController
  skip_before_action :authenticate_request!, only: [:index]

  def index
    render file: Rails.root.join('public', 'index.html'), layout: false, content_type: 'text/html'
  end
end
