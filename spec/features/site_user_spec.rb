require 'rails_helper'
require_relative '../support/page_form'
require_relative '../support/wait_for_ajax'

RSpec.feature "Site User", type: :feature do
  let(:links_page_form) { PageForm.new }
  let(:user) { create(:user) }
    
  before do
    create(:link, title: 'Link Page Title')
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
    
    scenario "submit a link", js: true do
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
    
    scenario "view links belonging to him/her" do
      link1 = create(:link, user: user)
      link2 = create(:link, user: user)
      links_page_form.visit_page
                .login_user(user)
                .click('links-btn')
                .click('My Links')
      
      expect(page).to have_content(link1.title)
      expect(page).to have_content(link2.title)
      expect(page).not_to have_content('Link Page Title')
    end
    
    scenario "change his/her username" do
      links_page_form.visit_page
                .login_user(user)
                .click('Edit Profile')
                .fill('Username': 'another-name',
                      'Current password': user.password)
                .click('Update')
                .click('Edit Profile')
      
      expect(page).to have_selector("input[value='another-name']")
    end
    
    scenario "change his/her password" do
      changed_password = 'changed-password'
      links_page_form.visit_page
                .login_user(user)
                .click('Edit Profile')
                .fill('Password': changed_password,
                      'Password confirmation': changed_password,
                      'Current password': user.password)
                .click('Update')
                .click('Logout')
      user.password = changed_password
      links_page_form.login_user(user)
      
      expect(page).to have_content('Edit Profile')
      expect(page).to have_content('Logout')
    end
    
    scenario "Edit a links details that belong to him/her" do
      link = create(:link, user: user)
      links_page_form.visit_page
                .login_user(user)
                .click(link.title)
                .click('Edit Link')
                .fill('Title': 'Updated Title',
                      'Description': 'Updated Description')
                .click('Update Link Details')
                
      expect(page).to have_content('Updated Title')
      expect(page).to have_content('Updated Description')           
    end
    
    scenario "Delete a link that belongs to him/her" do
      link = create(:link, user: user)
      links_page_form.visit_page
                .login_user(user)
                .click(link.title)  
                .click('Delete Link')
      
      expect(page).not_to have_content(link.title)
      expect(current_path).to eq(root_path)
    end
  end
  
end