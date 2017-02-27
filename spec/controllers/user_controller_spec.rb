require 'rails_helper'

RSpec.describe UserController, type: :controller do
  describe "GET #show" do
    let(:user) { create(:user) }
    before do
      get :show, params: { id: user.slug }      
    end
    
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    
    it "renders the :show template" do
      expect(response).to render_template(:show)
    end
  end
  
  describe "GET #submitted_links" do
    let(:user) { create(:user) }
    before do
      @link1 = create(:link, user: user)
      @link2 = create(:link, user: user)
      @link3 = create(:link)
      
      get :submitted_links, params: { id: user.slug }
    end
    
    it "renders the links/index template" do
      expect(response).to render_template('links/index')
    end
    
    it "only shows a user's submitted links" do
      expect(assigns(:links)).to contain_exactly(@link1, @link2)      
    end
  end

  describe "GET #approved_links" do
    let(:user) { create(:user) }
    before do
      @link1 = create(:link)
      @link2 = create(:link)
      @link3 = create(:link)
      
      @link1.approvers << user
      @link3.approvers << user
      
      get :approved_links, params: { id: user.slug }
    end
    
    it "renders the links/index template" do
      expect(response).to render_template('links/index')
    end
    
    it "only shows a user's approved links" do
      expect(assigns(:links)).to contain_exactly(@link1, @link3)      
    end
  end

end
