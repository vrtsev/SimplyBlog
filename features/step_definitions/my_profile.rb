Given(/^User 'Админ'/) do
  user = create :user, name: 'Admin', email: 'admin@example.com', password: 'password'
  login_as(user)
end

And(/^User posts/) do
  create_list :post, 3, user: User.last
end

And(/^User categories/) do
  create_list :category, 3, user: User.last
end

When(/^User visit his own page/) do
  visit posts_path
end

Then(/^He can see login status 'Вы вошли как Админ'/) do
  expect(page).to have_content 'Вы вошли как Admin'
  expect(page).to have_content 'Создать запись'
  expect(page).to have_content 'Новая категория'
end

And(/^He can see his posts/) do
  expect(page).to have_content 'New post'
end

And(/^He can see his categories/) do
  expect(page).to have_content 'User category 1'
  expect(page).to have_content 'User category 2'
  expect(page).to have_content 'User category 3'
end
