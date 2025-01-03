# app/controllers/contact_contents_controller.rb
class ContactContentsController < ApplicationController
    
    def edit
      @contact_content = ContactContent.first_or_initialize
    end
  
    def update
      @contact_content = ContactContent.first_or_initialize
      if @contact_content.update(contact_content_params)
        redirect_to contact_path, notice: 'Contact content updated successfully.'
      else
        render :edit
      end
    end
  
    private
  
    def contact_content_params
      params.require(:contact_content).permit(:content)
    end
  end
  