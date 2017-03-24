And(/^i press button 'Создать запись'/) do
  within(:css, 'nav.navbar') { click_link 'Создать запись' }
end

And(/^page should contain post fields/) do
  find_field('post[title]')
  find_field('post[content]')
  find_field('post[category_id]')
  find_field('post[tag_list]')
  find_field('post[pin]')
end

And(/^i set pin post to '([^']*)'/) do |pin|
  check 'post[pin]' if pin == 'true'
end

And(/^i press confirmation button/) do
  click_button 'Сохранить'
end

Given(/^([^']*)'s post with data:/) do |user, table|
  table.hashes.each do |data|
    steps %(
      Given user with name '#{user}' and email '#{user.downcase}@blog.net'
      And i sign in as '#{user.downcase}@blog.net'
      When i visit new post page
      And i fill 'post[title]' field with '#{data['title']}'
      And i fill 'post[content]' field with '#{data['content']}'
      And i fill 'post[tag_list]' field with '#{data['tags']}'
      And i select '#{data['category']}' from 'post[category_id]'
      And i set pin post to '#{data['pin']}'
      And i press confirmation button
      Then site should redirect to show post page
      And page should contain title '#{data['title']}'
      And page should contain content '#{data['content']}'
    )
  end
end

And(/^i select '([^']*)' from '([^']*)'/) do |option, select_box|
  select(option, from: select_box)
end
