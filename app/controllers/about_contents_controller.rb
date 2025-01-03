class AboutContentsController < ApplicationController
    
    def edit
      @about_content = AboutContent.first_or_initialize
    end
  
    def update
      @about_content = AboutContent.first_or_initialize
      if @about_content.update(about_content_params)
        redirect_to about_path, notice: 'About content updated successfully.'
      else
        render :edit
      end
    end
  
    private
  
    def about_content_params
      params.require(:about_content).permit(:content)
    end
  end