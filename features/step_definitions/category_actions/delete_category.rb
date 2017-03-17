# Given(/^Category page/) do
  
# end

# When(/^I click category settings button/) do
# end

And(/^Press delete button/) do
  click_link 'Удалить'
end

# Then(/^Site should redirect to profile page/) do
# end

And(/^page should not contain deleted category/) do
  expect(page).to have_no_content('My category')
end