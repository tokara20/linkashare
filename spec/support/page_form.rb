class PageForm
  include Capybara::DSL
  
  def visit_page
    visit('/')
    self
  end
  
  def fill(fields)
    fields.each do |label, value|
      fill_in(label, with: value)    
    end
    self
  end
  
  def click(text, wrapper = nil)
    if wrapper
      within(:css, wrapper) do
        click_on(text)
      end
    else
      click_on(text)
    end
    self
  end
  
  def login_user(user)
    self.visit_page.click('Login')
        .fill('Email': user.email, 'Password': user.password)
        .click('Login', 'form')  
  end
end