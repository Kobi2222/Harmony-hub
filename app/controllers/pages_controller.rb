# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def about
    @about_content = AboutContent.last.content
  end

  def contact
    @contact_content = ContactContent.last.content
  end
end
