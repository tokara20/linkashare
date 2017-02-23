require 'rails_helper'
require_relative '../support/page_form'
require_relative '../support/wait_for_ajax'

RSpec.feature "Site User", type: :feature do
  let(:links_page_form) { PageForm.new }
  let(:user) { create(:user) }
    
  before do
    create(:link, title: 'Link Page Title')
    create(:link, title: 'Some Other Title')
    create(:link, title: 'Sample Title',
                  description: 'Sample Description')
  end
    
  context "A site user should be able to" do
    scenario "return to the root page" do
      links_page_form.visit_page
                 .login_user(user)
                 .visit_page
      
      expect(page).to have_content('Linkashare')
      expect(page).to have_content('Link Page Title')
      expect(page).to have_content('Sample Description')
    end
    
    scenario "go to a link page" do
      links_page_form.visit_page
                .login_user(user)
                .visit_page
                .click('Link Page Title')
      
      expect(page).to have_content('Link Page Title')
      expect(page).to have_content('Visit Site')
    end
    
    scenario "go to the about page" do
      links_page_form.visit_page
                .login_user(user)
                .visit_page
                .click('About')
                
      expect(page).to have_css('h1', text: 'About')
    end
    
    scenario "submit a link", js: true, focus: true do
      # gives warning:
      # Fontconfig warning: ignoring C.UTF-8: not a valid language tag
      # It comes from phantomjsexport
      # Solution:
      # https://github.com/ariya/phantomjs/issues/12835
      url = "https://www.yahoo.com/"
      links_page_form.visit_page
                .login_user(user)
                .click('links-btn')
                .click('New Link')
                .fill('Url': url)
                .click('Fetch Url')
      wait_for_ajax(10)     
      links_page_form.click('Add Link')
      wait_for_ajax(10)     
      
      expect(find_link('Visit Site')[:href]).to eq(url)
    end
  end
  
  context "A site user should not be able to" do
      
  end
end