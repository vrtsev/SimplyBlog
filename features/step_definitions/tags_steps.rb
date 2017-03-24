Then(/^url should be for ([^']*)'s '([^']*)' tag/) do |username, tagname|
  user = User.find_by name: username
  assert_current_path "/id#{user.id}?tag=#{tagname}"
end
