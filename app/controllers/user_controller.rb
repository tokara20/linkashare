class UserController < ApplicationController
  before_action :set_ransack_search_object, only: [:submitted_links,
                                                   :approved_links]
  
  def show
    begin
      @user = User.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      # Shows 'User not found' in view
    end
  end
  
  def submitted_links
    begin
      user = User.friendly.find(params[:id])
      @links = Link.where(user: user).order(created_at: :desc)
                 .paginate(:page => params[:page],
                           :per_page => LinksController::LinksPerPage)
      render 'links/index'
    rescue ActiveRecord::RecordNotFound
      render 'error'
    end
  end
  
  def approved_links
    begin
      user = User.friendly.find(params[:id])
      @links = user.approved_links.order(created_at: :desc)
                 .paginate(:page => params[:page],
                           :per_page => LinksController::LinksPerPage)
      render 'links/index'
    rescue ActiveRecord::RecordNotFound
      render 'error'
    end
  end
  
  private
  
  def set_ransack_search_object
    @q = Link.ransack(params[:q])
  end
end
