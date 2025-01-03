# app/controllers/errors_controller.rb
class ErrorsController < ApplicationController
    def not_found
      response.status = 404
        
      # Render the 404.html.erb page in the public directory
      render file: Rails.public_path.join('404.html'), layout: false
    end
end