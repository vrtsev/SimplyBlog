When(/^i'm going to visit ([^']*)'s profile/) do |username|
  user = User.find_by name: username
  visit profile_path(user)
end

And(/^page should include user profile fields/) do
  page.has_no_field?('user[name]')
  page.has_no_field?('user[email]')
  page.has_no_field?('user[password]')
  page.has_no_field?('user[password_confirmation]')
  page.has_no_field?('user[photo]')
end
