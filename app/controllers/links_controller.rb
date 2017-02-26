class LinksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_link, only: [:show, :edit, :update, :destroy,
    :approve_link, :unapprove_link]
  before_action :set_ransack_search_object
  
  authorize_resource
  skip_authorize_resource only: [:my_links, :approve_link, :unapprove_link]
  
  LinksPerPage = 10
    
  def index
    if params[:search_btn]
      @links = @q.result(distinct: true).order(created_at: :desc)
                 .paginate(:page => params[:page], :per_page => LinksPerPage)
    else
      @links = Link.order(created_at: :desc)
                   .paginate(:page => params[:page], :per_page => LinksPerPage)
    end
  end
  
  def my_links
    @links = Link.where(user: current_user).order(created_at: :desc)
                 .paginate(:page => params[:page], :per_page => LinksPerPage)
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
          render 'url_error' and return  # url_error.js.erb
        end
        @link.url = link_data.url
        
        if params[:fetch_url]  # first step: fetch url data
          @link.title = link_data.title
          @link.description = link_data.description
        elsif params[:add_link]  # second step: actual record creation
          @link.fetch_website_image(link_data)
          @link.title = link_params[:title]
          @link.description = link_params[:description]
          @link.user = current_user
          
          # image spoofing detection workaround
          # just set website_image_file_name to false
          if @link.errors[:website_image].first =~
             /has contents that are not what they are reported to be/
            @link.website_image_file_name = false
          end
          
          if @link.save
            redirect_to @link
          else
            render 'create' # create.js.erb
          end
        end
        
      end # format
    end # respont_to
  end
  
  def show
    @comments = @link.comments.includes(:user)
  end
  
  def approve_link
    respond_to do |format|
      format.js do
        begin 
          @link.approvers << current_user
        ensure
          render 'approve_link'
        end
      end
    end
  end
  
  def unapprove_link
    respond_to do |format|
      format.js do
        begin
          @link.approvers.delete(current_user)
        ensure
          render 'approve_link'
        end
      end
    end
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
  
  def set_ransack_search_object
    @q = Link.ransack(params[:q])
  end
  
  def find_link
    @link = Link.find(params[:id])
  end
  
  def link_params
    params.require(:link).permit(:url, :title, :description, :website_image)
  end
end
