class LinksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_link, only: [:show, :edit, :update, :destroy]
  
  authorize_resource
  skip_authorize_resource only: [:my_links]
    
  def index
    @links = Link.order(created_at: :desc)
  end
  
  def my_links
    @links = Link.where(user: current_user).order(created_at: :desc)
    render 'index'
  end
  
  def new
    @link = Link.new
  end
  
  def create
    respond_to do |format|
      format.js do
        @link = Link.new
        link_data = @link.get_link_data(link_params[:url])
        unless link_data
          render 'new' and return
        end
        if params[:fetch_url]
          @link.url = link_params[:url]
          @link.title = link_data.title
          @link.description = link_data.description
        elsif params[:add_link]
          # save thumbnail to image_path
           
        
          @link.url = link_params[:url]
          @link.fetch_website_image(link_data)
          @link.title = link_params[:title]
          @link.description = link_params[:description]
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
  end
  
  def edit
  end
  
  def update
    if @link.update(title: link_params[:title], 
         description: link_params[:description])
      redirect_to @link
    else
      render 'show'
    end
  end
  
  def destroy
    @link.destroy
    redirect_to root_path
  end
  
  private
  
  def find_link
    @link = Link.find(params[:id])
  end
  
  def link_params
    params.require(:link).permit(:url, :title, :description, :website_image)
  end
end
