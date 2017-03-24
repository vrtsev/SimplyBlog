Given(/^([^']*)'s category with name '([^']*)'/) do |username, cat_name|
  user = User.find_by name: username
  Category.create name: cat_name, user: user
end

#
# REFACTOR!!!!
#
Then(/^url should be for ([^']*)'s '([^']*)' category/) do |username, cat_name|
  user = User.find_by name: username
  category = Category.find_by name: cat_name, user: user
  assert_current_path "/id#{user.id}?category=#{category.id}"
end
