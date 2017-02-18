class LinksController < ApplicationController
  before_action :authenticate_user!, only: [:new]  
    
  def index
    @links = Link.order(created_at: :desc)
  end
  
  def new
    @link = Link.new
  end
  
  def create
    respond_to do |format|
      format.js do
        if params[:fetch_url]
          # add url checking
          @link = Link.new
          begin
            link_data = LinkThumbnailer.generate(link_params[:url])
          rescue
            @link.errors.add(:url, "Unable to reach link.")
            render 'new' and return
          end
        
          # fill in other fields
          @link.url = link_params[:url]
          @link.title = link_data.title
          @link.description = link_data.description
        elsif params[:add_link]
          link_data = LinkThumbnailer.generate(link_params[:url])
         
          byebug
          # save thumbnail to image_path
          unless link_data.images.empty?
            image = open(link_data.images.first.src.to_s)
            filename = image.base_uri.to_s.split('/')[-1]
            image_path = Rails.root.join('tmp', filename)   
            IO.copy_stream(image, image_path)
          end
        
          # fill in other fields
          @link = Link.new
          @link.url = link_params[:url]
          @link.title = link_params[:title]
          @link.description = link_params[:description]
          unless link_data.images.empty?
            File.open(image_path, 'rb') do |file|
              @link.website_image = file
            end
          end
          @link.user = current_user
          
          if @link.save
            redirect_to @link
          else
            render 'new'
          end
        end
        
      end # format
    end # respont_to
  end
  
  def show
    @link = Link.find(params[:id])
  end
  
  private
  
  def link_params
    params.require(:link).permit(:url, :title, :description, :website_image)
  end
end
