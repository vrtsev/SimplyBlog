Given(/^I as user Admin wih posts and categories/) do
  admin = create(:user, name: 'Admin', email: 'admin@example.com', password: 'password')
  login_as(admin)
  create :category, name: 'Admin category', user: admin
  create :post, title: 'Admin post', user: admin
end

And(/^user David wih posts and categories/) do
  david = create(:user, name: 'David', email: 'david@example.com', password: 'password')
  create :category, name: 'David category', user: david
  create :post, title: 'David post', user: david
end

When(/^i visit David profile/) do
  visit "/id#{User.last.id}"
end

Then(/^i should see David name/) do
  expect(page).to have_content 'David'
end

And(/^i should see David posts/) do
  expect(page).to have_content 'David post'
end

And(/^i should see David categories/) do
  expect(page).to have_content 'David category'
end
