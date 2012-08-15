
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    # common paths
    when /the home\s?page/
      root_path
    when /the sign up page/
      new_user_registration_path
      
      
    when /the welcome user page/
      welcome_path
    when /forget password page/
      new_user_password_path
    when /the (user )?dashboard page/
      user_root_path
    when /the sign in page/
      new_user_session_path
    when /the sign out page/
      destroy_user_session_path
    when /the edit user profile page/
      edit_user_path
  
    when /the user account settings page/
      edit_account_user_path
    when /the user privacy settings page/
      edit_privacy_user_path
    when /the user edit membership page/
      edit_membership_user_path
    when /the my activity page/
      activity_erer_path
    when /the new project page/
      new_company_project_path(@company)
    when /the new company page/
      new_company_path
    when /the my company sign in page/
      new_user_session_path
    # custom company paths
    when /the company "([^"]*)" page/
      root_path(company_id: $1)
    when /the user activity page/
      activity_user_path
    when /the admin sign in page/
      new_admin_user_session_path
    when /the admin dashboard page/
      admin_user_root_path
    when /the browse known companies page/
      admin_known_companies_path
    when /the message page/
      messages_path
    when /the new company page/
      new_company_path
    when /the company dashboard page/
      company_user_dashboard_path(@company)
    when /the company admin dashboard page/
      company_admin_dashboard_path(@company)
    when /the company edit profile page/
      edit_company_profile_path(@company)
    when /the edit company contacts page/
     edit_company_contact_path(@company)
    when /the edit company associations page/
      edit_company_associations_path(@company)
    when /the edit company services page/
       edit_company_services_path(@company)
    when /the message reply page/
      reply_messages_path(@message.id)
    when /the new wikipage/
      new_wikipage_path(@company)
    when /the company reviews page/      
      company_reviews_path(@company)
    when /the company memberships page/
      company_memberships_path(@company)
    when /the address book page/
      contacts_path
    when /the outgoing request's edit page/
      edit_outgoing_request_path @quote_request
      
    # the following are examples using path_to_pickle
    when /^#{capture_model}(?:'s)? page$/                           # eg. the forum's page
      path_to_pickle $1

    when /^#{capture_model}(?:'s)? #{capture_model}(?:'s)? page$/   # eg. the forum's post's page
      path_to_pickle $1, $2

    when /^#{capture_model}(?:'s)? #{capture_model}'s (.+?) page$/  # eg. the forum's post's comments page
      path_to_pickle $1, $2, :extra => $3                           #  or the forum's post's edit page

    when /^#{capture_model}(?:'s)? (.+?) page$/                     # eg. the forum's posts page
      path_to_pickle $1, :extra => $2                               #  or the forum's edit page

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))
    when /"(.*)" profile's page/
      user_path(:id => $1)

    when /"(.*)" Company Profile/
      company_path(Company.find_by_name($1))
    
    when /the search result page/
      searches_path   
    
    when /the Send Request page for "(.*)"/
      send_request_company_outgoing_request_path(@company, OutgoingRequest.find_by_name($1).id)
    
    when /the "(\/[^"]*)" page/
      $1
    
    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
