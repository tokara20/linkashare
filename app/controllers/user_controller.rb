class UserController < ApplicationController
  def show
    begin
      @user = User.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      # head :not_found
    end
  end
end
