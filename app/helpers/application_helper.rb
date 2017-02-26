module ApplicationHelper
  def new_link_text
    'New Link'
  end
  
  def sign_up_text
    'Sign Up'
  end
  
  def login_text
    'Login'
  end
  
  def logout_text
    'Logout'
  end
  
  def edit_profile_text  
    'Edit Profile'
  end
  
  def my_links_text
    'My Links'
  end
  
  def approval_display_text
    raw '<span class="glyphicon glyphicon-ok"></span>'
  end
  
  def approved_links_text
    'My Approved Links'
  end
end
