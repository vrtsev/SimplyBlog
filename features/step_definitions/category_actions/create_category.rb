Given(/^Category creation form/) do
  user = create(:user, name: 'Admin', email: 'admin@example.com', password: 'password')
  login_as(user)
  visit posts_path
  click_link 'Новая категория'
  expect(page).to have_content('Создание новой категории')
end

When(/^I fill up fields/) do
  fill_in('category[name]', with: 'My category')
  fill_in('category[description]', with: 'My category description')
end

And(/^Press create category button/) do
  click_button 'Сохранить'
end

Then(/^Site should redirect to category page/) do
  expect(page).to have_current_path(posts_path(category: Category.last.id))
end

And(/^Page should contain category name/) do
  expect(page).to have_content 'My category'
end