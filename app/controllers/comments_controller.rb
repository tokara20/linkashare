class CommentsController < ApplicationController
  def create
    respond_to do |format|
      format.js do
        @link = Link.find(params[:link_id])
        @comment = @link.comments.create(content: comment_params[:content],
                   user: current_user)
        if @comment.errors.any?
          render 'create_error'  # create_error.js.erb
        end
        
        # create.js.erb
      end
    end
  end
  
  def destroy
    respond_to do |format|
      format.js do
        @link = Link.find(params[:link_id])
        @comment = @link.comments.find(params[:id])
        @comment.destroy
        
        @comments = @link.comments
        # destroy.js.erb
      end
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)  
  end
end