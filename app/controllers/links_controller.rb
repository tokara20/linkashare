class LinksController < ApplicationController
  before_action :authenticate_user!, only: [:new]  
    
  def index
      
  end
  
  def new
    @link = Link.new
  end
  
  def create
    respond_to do |format|
      format.js do
        if params[:fetch_url]
          # add url checking
          link_data = LinkThumbnailer.generate(link_params[:url])
         
          # save thumbnail to image_path
          image = open(link_data.images.first.src.to_s)
          filename = image.base_uri.to_s.split('/')[-1]
          image_path = Rails.root.join('public/temp', filename)   
          IO.copy_stream(image, image_path) 
        
          #byebug
          # fill in other fields
          @link = Link.new
          @link.url = link_params[:url]
          @link.title = link_data.title
          @link.description = link_data.description
          File.open(image_path, 'rb') do |file|
            @link.website_image = file
          end
          @link.save # for website_image to be stored
          
          #byebug
        end
        
      end
    end
  end
  
  private
  
  def link_params
    params.require(:link).permit(:url, :title, :description, :website_image)
  end
end
