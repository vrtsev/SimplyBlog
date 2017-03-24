And(/^2 posts with same tag/) do
  admin = User.find_by name: 'Admin'
  create_list :post, 2, :same_tag, title: 'Same post', user: admin
end

And(/^1 post with another tag/) do
  admin = User.find_by name: 'Admin'
  create :post, :another_tag, title: 'Another post', user: admin
end

When(/^I click another tag/) do
  visit posts_path
  click_link 'another'
end

Then(/^I should see post with another tag/) do
  expect(page).to have_no_content('Same post')
  expect(page).to have_content('Another post')
end
