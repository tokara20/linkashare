require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  describe "GET #index" do
    it "renders :index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end
  
  describe "GET show" do
    let (:link) { create(:link) }    
      
    it "renders :show template" do
      get :show, params: { id: link }
      expect(response).to render_template(:show)
    end
  end
  
  context "for guests" do
    
  end
  
  context "for logged-in users" do
    let(:user) { create(:user) }
    let (:link) { create(:link, user: user) }  
    
    before do
      sign_in(user)
    end
    
    describe "GET mylinks" do
      it "renders :index template" do
        get :my_links
        expect(response).to render_template(:index)
      end
    end
    
    describe "GET new" do
      it "renders :new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end
    
    describe "GET edit" do
      it "renders :edit template" do
        get :edit, params: { id: link }
        expect(response).to render_template(:edit)
      end
    end
  end
end
