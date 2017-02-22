require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  describe "GET #index" do
    it "renders :index template" do
      get :index
      expect(response).to render_template(:index)
    end
    
    it "lists all links" do
      link1 = create(:link)  
      link2 = create(:link)   
      link3 = create(:link)
      
      get :index
      expect(assigns(:links)).to contain_exactly(link1, link2, link3)
    end
  end
  
  describe "GET show" do
    let (:link) { create(:link) }    
      
    it "renders :show template" do
      get :show, params: { id: link }
      expect(response).to render_template(:show)
    end
    
    it "shows the correct link" do
      get :show, params: { id: link }
      expect(assigns(:link)).to eq(link)
    end
  end
  
  context "For Guests" do
    let (:link) { create(:link) }    
      
    describe "GET mylinks" do
      it "redirects to the login page" do
        get :my_links
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "GET new" do
      it "redirects to the login page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "GET edit" do
      it "redirects to the login page" do
        get :edit, params: { id: link }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "POST create" do
      it "returns an http status of 401" do
         post :create, params: { link: attributes_for(:link), 
                                 add_link: "Add Link" }, xhr: true
         expect(response).to have_http_status(401)  # Unauthorized
      end
    end
    
    describe "PUT update" do
      it "redirects to the login page" do
        link.title = "Modified Title"
        put :update, params: { id: link.id, link: link.attributes }      
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
    describe "DELETE destroy" do
      it "redirects to the login page" do
        delete :destroy, params: { id: link.id }    
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
  
  context "For Logged-in Users" do
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
      
      it "lists only links that belong to the user" do
        logged_in_user = user
        another_user = create(:user)
        
        link1 = link
        link2 = create(:link, user: logged_in_user)
        link3 = create(:link, user: logged_in_user)
        link4 = create(:link, user: another_user)
        link5 = create(:link, user: another_user)
        
        get :my_links
        expect(assigns(:links)).to contain_exactly(link1, link2, link3)
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
    
    describe "POST create" do
      before do
        allow_any_instance_of(Link).to receive(:get_link_data).and_return(true)
        allow_any_instance_of(Link).to receive(:fetch_website_image)    
      end
        
      it "response to be ok" do
         post :create, params: { link: attributes_for(:link), 
                                 add_link: "Add Link" }, xhr: true
         expect(response).to be_ok
      end
      
      it "saves the new link in the database" do
        just_a_link = build(:link)
        
        expect do
          post :create, params: { link: just_a_link.attributes, 
                                 add_link: "Add Link" }, xhr: true    
        end.to change(Link, :count).by(1)
      end
    end
    
    describe "PUT update" do
      before do
        link.title = "Modified Title"
        put :update, params: { id: link.id, link: link.attributes }    
      end
        
      it "redirects to the updated link page" do
        expect(response).to redirect_to(link)
      end
      
      it "updates the link in the database" do
        link.reload
        expect(link.title).to eq("Modified Title")
      end
    end
    
    describe "DELETE destroy" do
      before do
        delete :destroy, params: { id: link.id }    
      end
        
      it "redirects to the root path" do
        expect(response).to redirect_to(root_path)
      end
      
      it "deletes the link in the database" do
        expect(Link.exists?(link.id)).to be_falsy
      end
    end
    
    
  end
end
