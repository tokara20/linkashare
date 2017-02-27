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
  
  def fetching_url_text
    raw('<i class="fa fa-spinner fa-pulse fa-1x fa-fw"></i>' +
        ' <strong>Fetching Url...</strong>')
  end
  
  def adding_link_text
     raw('<i class="fa fa-spinner fa-pulse fa-1x fa-fw"></i>' +
        ' <strong>Adding Link...</strong>')
  end
  
  def search_text
    raw('<span class="glyphicon glyphicon-search" aria-hidden="true"></span>' +
        ' Search')
  end
  
  def searching_text
    raw('<span class="glyphicon glyphicon-search" aria-hidden="true"></span>' +
        ' Searching...')
  end
  
  def search_visible
    (controller_name == "links") ||
    (  (controller_name == "user") && 
       ((action_name == "submitted_links") || (action_name == "approved_links"))
    )
  end
end
