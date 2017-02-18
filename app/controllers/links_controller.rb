class LinksController < ApplicationController
  before_action :authenticate_user!, only: [:new]  
    
  def index
      
  end
  
  def new
    @link = Link.new
  end
end
