And(/^pinned post/) do
  admin = User.find_by name: 'Admin'
  create :post, title: 'Important post', user: admin, pin: true
end

# When(/^I visit my profile page/) do
#   visit posts_page
# end

Then(/^page should contains pinned post/) do
  within(:css, 'div.alert-danger') do
    expect(page).to have_content('Important post')
  end
end

And(/^the same post in timeline/) do
  within(:css, 'div.alert-warning') do
    expect(page).to have_content('Important post')
  end
end