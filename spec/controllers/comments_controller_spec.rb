require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:link) { create(:link) }
  let!(:comment) { build(:comment) }
    
  describe "POST #create" do
    it "has a response of ok" do
      post :create, params: { comment: comment.attributes,
                              link_id: link.id }, xhr: true
      expect(response).to be_ok
    end
    
    it "saves the new comment in the database" do
        expect do
          post :create, params: { comment: comment.attributes,
                                  link_id: link.id }, xhr: true
        end.to change(Comment, :count).by(1)
      end
  end
  
  describe "DELETE #destroy" do
     it "deletes the comment in the database" do
        link.comments << comment
        delete :destroy, params: { id: comment.id,
                                   link_id: link.id }, xhr: true   
        expect(Comment.exists?(comment.id)).to be_falsy
      end    
  end
end