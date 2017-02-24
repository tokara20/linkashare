require 'rails_helper'
require_relative '../support/page_form'

RSpec.feature "Site Visitor", type: :feature do
  let(:links_page_form) { PageForm.new }
  before do
    create(:link, title: 'Link Page Title')
    create(:link, description: 'Sample Description')
  end
    
  context "A site visitor should be able to" do
    scenario "view the root page" do
      links_page_form.visit_page   
      
      expect(page).to have_content('Linkashare')
      expect(page).to have_content('Link Page Title')
      expect(page).to have_content('Sample Description')
    end
    
    scenario "go to a link page" do
      links_page_form.visit_page
                .click('Link Page Title')
      
      expect(page).to have_content('Link Page Title')
      expect(page).to have_content('Visit Site')
    end
    
    scenario "go to the about page" do
      links_page_form.visit_page
                .click('About')
                
      expect(page).to have_css('h1', text: 'About')
    end
    
    scenario "Search for links" do
      create(:link, title: 'Yet Another Site')
      create(:link, description: 'Some Description')
      create(:link, description: 'Site. To Be Matched**')
      
      links_page_form.visit_page
                .fill('q_title_or_description_cont': 'To Be Matched')
                .click('Search', 'form')
                
      expect(page).to have_content('To Be Matched')
      expect(page).not_to have_content('Yet Another Title')
      expect(page).not_to have_content('Some Description')
    end
  end
  
end