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

end
