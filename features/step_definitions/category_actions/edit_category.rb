Given(/^Category page/) do
  user = create(:user, name: 'Admin', email: 'admin@example.com', password: 'password')
  login_as(user)
  create :category, name: 'My category', user: user
  visit category_path(Category.last)
end

When(/^I click category settings button/) do
  click_link 'Настройка'
end

And(/^Fill up fields for category/) do
  fill_in('category[name]', with: 'Edited category')
end

And(/^Press save button/) do
  click_button 'Сохранить'
end

Then(/^Site should redirect to profile page for category/) do
  expect(page).to have_current_path(posts_path)
end

And(/^page should contain edited category/) do
  expect(page).to have_content('Edited category')
end
