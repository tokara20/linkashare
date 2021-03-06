require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "GET #about" do
    it "renders the about page" do
      get :about
      expect(response).to render_template(:about)
    end
  end
end
