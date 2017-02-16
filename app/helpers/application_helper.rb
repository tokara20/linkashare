module ApplicationHelper
  def sign_up_text
    raw('<span class="glyphicon glyphicon-user"></span> Sign Up')
  end
  
  def login_text
    raw('<span class="glyphicon glyphicon-log-in"></span> Login')
  end
  
  def logout_text
    raw('<span class="glyphicon glyphicon-log-out"></span> Logout')
  end
  
  def edit_profile_text  
    raw('<span class="glyphicon glyphicon-user"></span> Edit Profile')  
  end
end
